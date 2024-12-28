library(tidyverse)

employ_data <- read.csv('Grad Survey Data.csv', stringsAsFactors = F)


# Replace na values with NA then remove -----------------------------------

employ_data <- employ_data |> 
  filter(!if_any(everything(), ~ . == 'na'))


# Clean names in school feature -------------------------------------------

employ_data$school[grepl("Dublin", employ_data$school)] <- "Trinity College Dublin"

employ_data <- employ_data %>%
  mutate(school = school %>%
           gsub('SIT', "", .) %>%
           gsub('\\(SIT\\)', "", .) %>%
           gsub('-', "", .) %>%
           gsub('\\*$|\\(\\)$', "", .) %>%
           gsub('\\(Nanyang Business School\\)$', "", .) %>%
           gsub('4year|4years', '4 year', .) %>%
           gsub('\\(NIE\\)', "", .) %>%
           gsub('Of', 'of', .) %>%
           gsub('YLL', 'Yong Loo Lin', .) %>%
           gsub('YST', 'Yong Siew Toh', .) %>%
           gsub('\\(Medicine\\)', 'of Medicine', .) %>%
           gsub('School of Business$', 'School of Business \\(4 year programme\\', .) %>%
           trimws()
  )


# Converting pay columns into numeric -------------------------------------

employ_data <- employ_data |> 
  mutate(across(5:12, as.numeric))

