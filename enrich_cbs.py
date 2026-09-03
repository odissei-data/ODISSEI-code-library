"""
Enrich _data/cbs.csv with CBS "data design" (dataset/table) info pulled from
the ODISSEI Knowledge Graph, matched on CBS_project_nr.

Run at build time (e.g. as a step in .github/workflows/jekyll.yml), before
`bundle exec jekyll build`. Safe to re-run: it always recomputes the
`data_design` column from the KG rather than appending to it.

Output format for the new `data_design` column (one cell per row):
    ShortTitle|https://doi.org/...|Dutch description; ShortTitle2|...|...

- One entry per distinct CBS table (shortTitle) the project uses, not one
  per dataset-version DOI (a table like GBAPERSOONTAB has many yearly
  versions, each its own DOI in the KG -- we collapse those to one entry).
- The DOI kept per table is a single representative one (the first
  encountered), since the point is "which table", not "which vintage".
- Where a table's Dutch description text varies slightly across versions,
  the most frequently occurring text is used.
"""

import csv
import re
import sys
from collections import Counter, defaultdict

import requests

SPARQL_ENDPOINT = "https://api.kg.odissei.nl/datasets/odissei/odissei-kg/services/odissei-virtuoso/sparql"
PROJECT_URI_PREFIX = "https://w3id.org/odissei/ns/kg/cbs/project/"
CBS_CSV_PATH = "_data/cbs.csv"

QUERY_TEMPLATE = """
PREFIX dct: <http://purl.org/dc/terms/>
PREFIX schema: <http://schema.org/>

SELECT ?project ?dataset ?shortTitle ?datasetTitle WHERE {{
  VALUES ?project {{
    {project_uris}
  }}
  ?project dct:requires ?datasetHash .
  ?datasetHash dct:alternative ?shortTitle .
  ?dataset dct:alternative ?shortTitle .
  ?dataset a schema:Dataset .
  OPTIONAL {{ ?dataset dct:title ?datasetTitle }}
}}
"""


def extract_project_numbers(csv_path):
    """Read cbs.csv and return the set of valid, numeric CBS_project_nr values."""
    numbers = set()
    with open(csv_path, newline="", encoding="utf-8") as f:
        for row in csv.DictReader(f):
            raw = (row.get("CBS_project_nr") or "").strip()
            if re.fullmatch(r"\d+", raw):
                numbers.add(raw)
    return numbers


def query_kg(project_numbers):
    """Run one batched SPARQL query for all project numbers, return rows."""
    if not project_numbers:
        return []
    uris = "\n    ".join(f"<{PROJECT_URI_PREFIX}{n}>" for n in sorted(project_numbers))
    query = QUERY_TEMPLATE.format(project_uris=uris)

    resp = requests.get(
        SPARQL_ENDPOINT,
        params={"query": query},
        headers={"Accept": "application/sparql-results+json"},
        timeout=30,
    )
    resp.raise_for_status()
    bindings = resp.json()["results"]["bindings"]

    rows = []
    for b in bindings:
        project_number = b["project"]["value"].rstrip("/").split("/")[-1]
        rows.append(
            {
                "project_number": project_number,
                "dataset": b["dataset"]["value"],
                "shortTitle": b["shortTitle"]["value"],
                "datasetTitle": b.get("datasetTitle", {}).get("value", ""),
            }
        )
    return rows


def build_data_design_map(kg_rows):
    """
    Collapse KG rows to one entry per (project_number, shortTitle), and
    return {project_number: "Short|DOI|Title; Short|DOI|Title; ..."}.
    """
    by_project = defaultdict(lambda: defaultdict(list))
    for r in kg_rows:
        by_project[r["project_number"]][r["shortTitle"]].append(r)

    result = {}
    for project_number, by_short in by_project.items():
        entries = []
        # sort for a stable, deterministic column order across re-runs
        for short_title in sorted(by_short):
            versions = by_short[short_title]
            representative_doi = sorted(v["dataset"] for v in versions)[0]
            titles = [v["datasetTitle"] for v in versions if v["datasetTitle"]]
            best_title = Counter(titles).most_common(1)[0][0] if titles else ""
            # escape our own field/entry separators if they ever show up in text
            best_title = best_title.replace("|", "/").replace(";", ",")
            entries.append(f"{short_title}|{representative_doi}|{best_title}")
        result[project_number] = "; ".join(entries)
    return result


def enrich_csv(csv_path, data_design_map):
    with open(csv_path, newline="", encoding="utf-8") as f:
        reader = csv.DictReader(f)
        fieldnames = reader.fieldnames
        rows = list(reader)

    if "data_design" not in fieldnames:
        fieldnames = fieldnames + ["data_design"]

    for row in rows:
        project_number = (row.get("CBS_project_nr") or "").strip()
        row["data_design"] = data_design_map.get(project_number, "")

    with open(csv_path, "w", newline="", encoding="utf-8") as f:
        writer = csv.DictWriter(f, fieldnames=fieldnames)
        writer.writeheader()
        writer.writerows(rows)


def main():
    project_numbers = extract_project_numbers(CBS_CSV_PATH)
    print(f"Found {len(project_numbers)} valid CBS project numbers.", file=sys.stderr)

    kg_rows = query_kg(project_numbers)
    print(f"KG returned {len(kg_rows)} dataset rows.", file=sys.stderr)

    data_design_map = build_data_design_map(kg_rows)
    enrich_csv(CBS_CSV_PATH, data_design_map)
    print(f"Enriched {len(data_design_map)} projects in {CBS_CSV_PATH}.", file=sys.stderr)


if __name__ == "__main__":
    main()
