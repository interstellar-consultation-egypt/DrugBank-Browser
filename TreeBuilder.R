library(data.tree)
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
drug <- Node$new("Drugs")
bio_tech <- drug$AddChild("Bio Tech")
small_molecule <- drug$AddChild("Small Molecule")
biotech_years <- drugs %>% filter(type == "biotech") %>% select(create_year) %>% distinct()
for (year in biotech_years$create_year) {
  bio_tech$AddChild(year)
}

small_molecule_years <- drugs %>% filter(type == "small molecule") %>% select(create_year) %>% distinct()
for (year in small_molecule_years$create_year) {
  small_molecule$AddChild(year)
}
small_molecule$children[[1]]$name
print(drug)
plot(drug)

## add months level and other levels
