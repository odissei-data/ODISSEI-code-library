#' ODISSEI code library -- LISS
#' Created by Angelica Maineri on 06-07-2023
#' #' 
#' 
#' 


# Load packages
library(tidyverse)
library(stringr)

# Load data
getwd()
df = read.csv("./data-prep/data/odissei-projects_LISS.csv", encoding = "UTF-8")

#### Cleaning ------- 

# sort alphabetically (by author)
df <- df[order(df$project_lead),]

# add hyperlinks
df2 = df |>
  mutate(publication = if_else(!is.na(publication), paste("<a href=\"", publication, "\"target=\"_blank\">", "doi</a>", sep = ""), " ")) |>
  mutate(project_lead = paste("<a href=\"", orcid, "\"target=\"_blank\">", project_lead, "</a>", sep = "")) |>
  mutate(title = paste("<a href=\"", code, "\"target=\"_blank\">", title, "</a>", sep = ""))


df2$link_data = gsub('https://','<a href="https://', df2$link_data )
df2$link_data = gsub('*$','"target=\"_blank\">data</a>', df2$link_data )
df2$link_data = gsub(';','"target=\"_blank\">data</a>;', df2$link_data )
df2$link_data[df2$link_data=='\">data</a>'] = ""

df2$link_data
df2$project_lead



df2 = df2 |> 
  select(-c("orcid", "publication.type", "code"))

head(df2)

colnames(df2) = c("Title", "Project lead", "ODISSEI grant", "Publication", "Data", "Link to data", "Code Language")
df2 = df2[,c(1,2,7,4,5,6,3)]

## Export ----
write.csv(df2, "./_data/liss.csv")
