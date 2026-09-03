# WARNING!
Note this is the outdated version of the ODISSEI code library. Please visit https://github.com/odissei-data/ODISSEI-code-library and https://odissei-data.github.io/ODISSEI-code-library/ for the most recent version.

# ODISSEI Code Library
The [ODISSEI code library](https://odissei-data.github.io/ODISSEI-code-library/) is a collection of code and scripts used to execute projects using the ODISSEI infrastructure. [ODISSEI](https://odissei-data.nl/en/) (Open Data Infrastructure for Social Science and Economic Innovations) is the national research infrastructure for the social sciences in the Netherlands. ODISSEI brings together researchers with the necessary data, expertise and resources to conduct ground-breaking research and embrace the computational turn in social enquiry. Through ODISSEI, researchers have access to large-scale, longitudinal data collections as well as innovative and diverse new forms of data. These can be linked to administrative data at Statistics Netherlands (CBS). Combining data from a wide range of sources enables researchers to answer new, exciting, interdisciplinary research questions and to investigate existing questions in novel, new ways.

# CBS data design enrichment
The data_design column in `_data/cbs.csv` is populated automatically from the [ODISSEI Knowledge Graph](kg.odissei.nl/), matched via each entry's CBS_project_nr. This happens at build time — a script (`enrich_cbs.py`) runs as a step in the GitHub Actions workflow before Jekyll builds the site, querying the KG's production SPARQL endpoint for every valid project number found in the CSV and writing back one entry per distinct CBS data table used (formatted as ShortCode|DOI|DutchTitle, separated by ; for projects using multiple tables), which the site then renders as clickable, filterable table codes with the Dutch title as a hover tooltip. This means the column is fully KG-managed: you never need to fill it in by hand when adding a new entry to `cbs.csv` — as long as the row has a plain numeric CBS_project_nr, the next build (triggered by any push, or automatically every Monday) will populate it — and any manual edits to that column will be overwritten on the next build. If the KG is temporarily unreachable during a build, the step fails safely (continue-on-error) and the site simply deploys with whichever data_design values were already committed from the last successful run. Note: Claude (Sonnet 5) was used to implement this upgrade

# Contribute
Do you want to submit your own project and code to be added to the library? Please submit an issue using the _Submission code_ issue template (or [send me an email](mailto:fairsupport@odissei-data.nl)).

# Update library
## Step 1: Clone repo

## Step 2: Update data
Edit the source files `_data/cbs.csv`, `_data/liss.csv` or `_data/port.csv`.

## Step 3: Commit changes to GitHub and create pull request
Commit your changes to a branch  of the GitHub repository.

## Step 4: Admire the result
Once the pull request is accepted, and the checks are all successful, the result will be visible on the [ODISSEI code library](https://odissei-data.github.io/ODISSEI-code-library/) within a few minutes.

## Local testing
If you would like to test locally, see [Testing your GitHub Pages site locally with Jekyll](https://docs.github.com/en/pages/setting-up-a-github-pages-site-with-jekyll/testing-your-github-pages-site-locally-with-jekyll). Once you have installed jekyll, you can simply run a local copy on your own machine by starting a server on the command line with:
```
$ bundle exec jekyll serve
```
