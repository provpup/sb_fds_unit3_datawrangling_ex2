# install.packages('dplyr')
# install.packages('tidyr')
# install.packages('readr')
library(dplyr)
library(tidyr)
library(readr)

data <- read_csv('./titanic_original.csv')
data <- tbl_df(data)

# Fill NA values with S for the embarked column
clean_embarked <- function (embarked) {
  return(ifelse(is.na(embarked), 'S', embarked))
}

mean_age = mean(data$age, na.rm = TRUE)
# Fill NA values with the mean age for the age column
clean_age <- function (age) {
  return(ifelse(is.na(age), mean_age, age))
}

# Fill NA values with 'None' for the boat column
clean_boat <- function (boat) {
  return(ifelse(is.na(boat), 'None', boat))
}

# Represent the presence of a cabin value as 1 and absence with 0
clean_cabin <- function (cabin) {
  return(as.numeric(!is.na(cabin)))
}

data <- data %>%
  mutate(embarked = sapply(embarked, clean_embarked),
         age = sapply(age, clean_age),
         boat = sapply(boat, clean_boat),
         has_cabin_number = sapply(cabin, clean_cabin))

write_csv(data, './titanic_clean.csv')