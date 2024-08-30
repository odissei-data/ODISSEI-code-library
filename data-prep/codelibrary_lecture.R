library(tidyverse)

cbsdf = read.csv("Data/odissei-projects-clean_CBS.csv")
lissdf = read.csv("Data/odissei-projects-clean_LISS.csv")


colnames(cbsdf)
colnames(lissdf)


df = full_join(cbsdf, lissdf)
head(df)


ggplot(df, aes(x=programming.language)) +
  geom_bar(fill="dodgerblue") +
  theme_classic() +
  xlab("Programming language")
ggsave("images/prog_lang.jpeg")


# repo
df = df |>
  mutate(registry = str_match(code, "https:\\/\\/\\s*(.*?)\\s*\\.") %>% .[,2])
df$registry  
  
df$registry[df$code=='<a href="https://doi.org/10.17605/OSF.IO/ZMH5N">link</a>'] = "osf"
df$registry[df$code=='<a href="https://doi.org/10.5281/zenodo.7443895">link</a>'] = "zenodo"
df$registry[df$code=='<a href="https://doi.org/10.1016/j.lanepe.2023.100749">link</a>'] = "other"
df$registry[df$code=='<a href="https://doi.org/10.7910/DVN/P39QGO">link</a>'] = "dataverse"
df$registry[df$code=='<a href="https://doi.org/10.7910/DVN/VMMMCL">link</a>'] = "dataverse"
df$registry[df$code=='<a href="https://doi.org/10.7910/DVN/5XYHJD">link</a>'] = "dataverse"

ggplot(df, aes(x=registry)) +
  geom_bar(fill="lightblue") +
  theme_classic() +
  xlab("Registry")
ggsave("images/registry.jpeg")
