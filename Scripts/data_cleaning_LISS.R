#' ODISSEI code library -- LISS
#' Created by Angelica Maineri on 06-07-2023
#' #' 
#' 
#' 


# Load packages
library(tidyverse)


# Load data
df = read.csv("C:/Users/angel/Documents/GitHub/ODISSEI-code-library/Data/odissei-projects_LISS.csv", encoding = "UTF-8")

#### Cleaning ------- 
# add hyperlinks
df2 = df |>
  mutate(publication = paste("<a href=\"", publication, "\">", publication.type, "</a>", sep = "")) |>
  mutate(code = paste("<a href=\"", code, "\">", "link</a>", sep = "")) |>
  mutate(project_lead = paste("<a href=\"", orcid, "\">", project_lead, "</a>", sep = ""))


df2 = df2 |> 
  select(-c("orcid", "publication.type"))

head(df2)


## Export ----
write.csv(df2, "Data/odissei-projects-clean_LISS.csv")
