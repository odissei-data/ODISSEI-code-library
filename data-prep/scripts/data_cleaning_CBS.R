#' ODISSEI code library -- CBS
#' Created by Angelica Maineri on 26-06-2023
#' 
#' To do:: add hyperlinks to data
#' 


# Load packages
library(tidyverse)


# Load data
getwd()
df = read.csv("~/GitHub/odissei/ODISSEI-code-library/data-prep/data/odissei-projects_CBS.csv", encoding = "UTF-8")

#### Cleaning ------- 

df$project_lead = gsub("<e8>", "è", df$project_lead)
df$project_lead = gsub("<e9?>", "é", df$project_lead)
df$project_lead = gsub("<e1?>", "á", df$project_lead)


# sort alphabetically (by author)
df <- df[order(df$project_lead),]

# add hyperlinks
df2 = df |>
  mutate(publication = if_else(!is.na(publication), paste("<a href=\"", publication, "\"target=\"_blank\">", "doi</a>", sep = ""), " ")) |>
  mutate(project_lead = paste("<a href=\"", orcid, "\"target=\"_blank\">", project_lead, "</a>", sep = "")) |>
  mutate(title = paste("<a href=\"", code, "\"target=\"_blank\">", title, "</a>", sep = ""))


df2 = df2 |> 
  select(-c("orcid", "code"))

head(df2)

colnames(df2) = c("Title", "CBS project nr.", "Project lead", "ODISSEI grant", "Publication", "Data", "Code Language")

df2 = df2[,c(1,3,7,5,6,2,4)]

#df2$`Project lead` = gsub("<e8>", "è", df2$`Project lead`)
#df2$`Project lead` = gsub("<e9>", "é", df2$`Project lead`)


## Export ----
write.csv(df2, "~/GitHub/odissei/ODISSEI-code-library/_data/cbs.csv")



