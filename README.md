# ODISSEI Code Library
The [ODISSEI code library](https://odissei-data.github.io/ODISSEI-code-library/) is a collection of code and scripts used to execute projects using the ODISSEI infrastructure. [ODISSEI](https://odissei-data.nl/en/) (Open Data Infrastructure for Social Science and Economic Innovations) is the national research infrastructure for the social sciences in the Netherlands. ODISSEI brings together researchers with the necessary data, expertise and resources to conduct ground-breaking research and embrace the computational turn in social enquiry. Through ODISSEI, researchers have access to large-scale, longitudinal data collections as well as innovative and diverse new forms of data. These can be linked to administrative data at Statistics Netherlands (CBS). Combining data from a wide range of sources enables researchers to answer new, exciting, interdisciplinary research questions and to investigate existing questions in novel, new ways.

# Contribute
Do you want to submit your own project and code to be added to the library? Please submit an issue using the _Submission code_ issue template (or [send me an email](mailto:fairsupport@odissei-data.nl)).

# Update library
## Step 1: Clone repo

## Step 2: Update data
Edit the files `data-prep/data/odissei-projects_*.csv`

## Step 3: Clean csv files
Open `ODISSEI-code-library.Rproj` and run the data cleaning scripts (`data-prep/scripts/data_cleaning_*.R`). Each script will generate a new dataset (`_data/*.csv`)

## Step 4: Commit changes to GitHub and create pull request
Commit your changes to (a branch  of) the GitHub repository.

## Step 5: Admire the result
Once the pull request is accepted, within a few minutes the result will be visible on the [ODISSEI code library](https://odissei-data.github.io/ODISSEI-code-library/). 
