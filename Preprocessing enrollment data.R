library(tidyverse)

enroll_data <- read.csv('Enrollment Data.csv', stringsAsFactors = F)

# Change MF value to M ----------------------------------------------------

enroll_data$sex <- ifelse(enroll_data$sex == 'MF', 'M', 'F')


# Fixing column -----------------------------------------------------------

enroll_data <- enroll_data |> 
  rename('enrollment' = 'enrolment')


# Removing rows where enrollment info is 0 --------------------------------

enroll_data <- enroll_data |> 
  filter(!if_any(everything(), ~ . == 0))


# Changing intake to numeric ----------------------------------------------

enroll_data$intake <- as.numeric(enroll_data$intake)

enroll_data <- na.omit(enroll_data)


