#' ODISSEI code library -- CBS
#' Created by Angelica Maineri on 26-06-2023
#' 
#' To do:: add hyperlinks to data
#' 


# Load packages
library(tidyverse)


# Load data
df = read.csv("C:/Users/angel/Documents/GitHub/odissei/ODISSEI-code-library/data-prep/data/odissei-projects_CBS.csv", encoding = "UTF-8")

#### Cleaning ------- 
# add hyperlinks
df2 = df |>
  mutate(publication = if_else(!is.na(publication), paste("<a href=\"", publication, "\">", "doi</a>", sep = ""), " ")) |>
  mutate(project_lead = paste("<a href=\"", orcid, "\">", project_lead, "</a>", sep = "")) |>
  mutate(title = paste("<a href=\"", code, "\">", title, "</a>", sep = ""))


df2 = df2 |> 
  select(-c("orcid", "code"))

head(df2)

colnames(df2) = c("Title", "CBS project nr.", "Project lead", "ODISSEI grant", "Publication", "Data", "Code Language")

df2 = df2[,c(1,3,7,5,6,2,4)]

df2$`Project lead` = gsub("<e8>", "è", df2$`Project lead`)

## Export ----
write.csv(df2, "C:/Users/angel/Documents/GitHub/odissei/ODISSEI-code-library/_data/cbs.csv")



