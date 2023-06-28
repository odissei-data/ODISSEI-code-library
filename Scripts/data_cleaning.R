#' ODISSEI code library
#' Created by Angelica Maineri on 26-06-2023
#' 
#' 
#' 


# Load packages
library(tidyverse)


# Load data
df = read_csv("C:/Users/angel/Documents/GitHub/ODISSEI-code-library/Data/odissei-projects.csv")

#### Cleaning ------- 
# add hyperlinks
df2 = df |>
  mutate(publication = paste("<a href=\"", publication, "\">", "doi</a>", sep = "")) |>
  mutate(code = paste("<a href=\"", code, "\">", "link</a>", sep = "")) |>
  mutate(project_lead = paste("<a href=\"", orcid, "\">", project_lead, "</a>", sep = ""))


df2 = df2 |> 
  select(-c("orcid"))

head(df2)


## Export ----
write.csv(df2, "Data/odissei-projects-clean.csv")
