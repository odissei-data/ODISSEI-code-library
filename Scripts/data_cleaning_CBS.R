#' ODISSEI code library -- CBS
#' Created by Angelica Maineri on 26-06-2023
#' 
#' To do:: add hyperlinks to data
#' 


# Load packages
library(tidyverse)


# Load data
df = read.csv("C:/Users/angel/Documents/GitHub/odissei/ODISSEI-code-library/Data/odissei-projects_CBS.csv", encoding = "UTF-8")

#### Cleaning ------- 
# add hyperlinks
df2 = df |>
  mutate(publication = paste("<a href=\"", publication, "\">", "doi</a>", sep = "")) |>
  mutate(code = paste("<a href=\"", code, "\">", "link</a>", sep = "")) |>
  mutate(project_lead = paste("<a href=\"", orcid, "\">", project_lead, "</a>", sep = ""))


df2 = df2 |> 
  select(-c("orcid"))

head(df2)

colnames(df2) = c("Title", "CBS project nr.", "Project lead", "ODISSEI grant", "Publication", "Data", "Code", "Code Language")

## Export ----
write.csv(df2, "Data/odissei-projects-clean_CBS.csv")



