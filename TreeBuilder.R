library(tidyverse)
library(lubridate)
drugs <- read_csv(file = "data/drugs.csv")
drugs$create_year <- year(drugs$created) 
drugs$create_month <- month(drugs$created)
drugs_names <- drugs$name
write(drugs_names, "data//drugs_names.csv")
drugs_names <- read_csv("data//drugs_names.csv", col_names = "name")


# Drug

## Bio Tech
### Year
#### Month
##### gas 
##### liquid 
##### solid

## Small Molecule
### Year
#### Month
##### gas 
##### liquid 
##### solid