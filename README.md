# ODISSEI Code Library
The [ODISSEI code library](https://odissei-data.github.io/ODISSEI-code-library/) is a collection of code and scripts used to execute projects using the ODISSEI infrastructure. [ODISSEI](https://odissei-data.nl/en/) (Open Data Infrastructure for Social Science and Economic Innovations) is the national research infrastructure for the social sciences in the Netherlands. ODISSEI brings together researchers with the necessary data, expertise and resources to conduct ground-breaking research and embrace the computational turn in social enquiry. Through ODISSEI, researchers have access to large-scale, longitudinal data collections as well as innovative and diverse new forms of data. These can be linked to administrative data at Statistics Netherlands (CBS). Combining data from a wide range of sources enables researchers to answer new, exciting, interdisciplinary research questions and to investigate existing questions in novel, new ways..

# Contribute
Do you want to submit your own project and code to be added to the library? Please submit an issue using the _Submission code_ issue template (or [send me an email](mailto:fairsupport@odissei-data.nl)).

# Update library
## Step 1: Clone repo

## Step 2: Update data
Edit the source files `_data/cbs.csv` or `_data/liss.csv`.

## Step 3: Commit changes to GitHub and create pull request
Commit your changes to (a branch  of) the GitHub repository.

## Step 4: Admire the result
Once the pull request is accepted, and the checks are all successful, the result will be visible on the [ODISSEI code library](https://odissei-data.github.io/ODISSEI-code-library/) within a few minutes.

## Local testing
If you would like to test locally, see [Testing your GitHub Pages site locally with Jekyll](https://docs.github.com/en/pages/setting-up-a-github-pages-site-with-jekyll/testing-your-github-pages-site-locally-with-jekyll). Once you have installed jekyll, you can simply run a local copy on your own machine by starting a server on the command line with:
```
$ bundle exec jekyll serve
```