#' ODISSEI code library -- LISS
#' Created by Angelica Maineri on 06-07-2023
#' #' 
#' 
#' 


# Load packages
library(tidyverse)
library(stringr)

# Load data
df = read.csv("C:/Users/angel/Documents/GitHub/odissei/ODISSEI-code-library/Data/odissei-projects_LISS.csv", encoding = "UTF-8")

#### Cleaning ------- 
# add hyperlinks
df2 = df |>
  mutate(publication = paste("<a href=\"", publication, "\">", publication.type, "</a>", sep = "")) |>
  mutate(code = paste("<a href=\"", code, "\">", "link</a>", sep = "")) |>
  mutate(project_lead = paste("<a href=\"", orcid, "\">", project_lead, "</a>", sep = ""))


df2$link_data = gsub('https://','<a href="https://', df2$link_data )
df2$link_data = gsub('*$','">data</a>', df2$link_data )
df2$link_data = gsub(';','">data</a>;', df2$link_data )
df2$link_data[df2$link_data=='\">data</a>'] = ""

df2$link_data
df2$project_lead



df2 = df2 |> 
  select(-c("orcid", "publication.type"))

head(df2)

colnames(df2) = c("Title", "Project lead", "ODISSEI grant", "Publication", "Data", "Link to data", "Code", "Code Language")


## Export ----
write.csv(df2, "Data/odissei-projects-clean_LISS.csv")
