library(data.tree)
library(tidyverse)
library(lubridate)
library(forcats)
library(collapsibleTree)
# Build new data fram for tree browser
## Read drugs
drugs <- read_csv(file = "data/drugs.csv")
drugs$type <- as.factor(drugs$type)
drugs$state <-fct_explicit_na(drugs$state, "Unknown") 
## Read Groups
drug_groups <- read_csv("data/drug_groups.csv")
## merge boths
drugs_all <- drugs %>% 
  select(primary_key, type = type, state, created) %>%
  full_join(drug_groups, by = c("primary_key" = "parent_key")) %>% 
  rename(group = "text") %>% 
  mutate(created_year = year(created), created_month = month(created))
# %>% 
#   mutate(pathString = paste("drugs", type, group, state, created_year, created_month, sep = "/"))

# examples
collapsibleTree(drugs_all, c("created_year", "created_month", "group", "state"))
collapsibleTree(drugs_all, c("state", "group","created_year", "created_month"))
# drugs_tree <- as.Node(drugs_all)
# collapsibleTree(drugs_tree)
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

# level 1 (main node)
drug <- Node$new("Drugs")
## level 2
small_molecule <- drug$AddChild("Small Molecule")
### level 3
approved_small_molecule <- small_molecule$AddChild("Approved")
#### level 4
us_approved_small_molecule <- approved_small_molecule$AddChild("U.S.")
canada_approved_small_molecule <- approved_small_molecule$AddChild("Canada")
eu_approved_small_molecule <- approved_small_molecule$AddChild("E.U.")
### level 3
approved_vet_small_molecule <- small_molecule$AddChild("Vet Approved")
#### level 4
us_approved_vet_small_molecule <- approved_vet_small_molecule$AddChild("U.S.")
canada_approved_vet_small_molecule <- approved_vet_small_molecule$AddChild("Canada")
eu_approved_vet_small_molecule <- approved_vet_small_molecule$AddChild("E.U.")
experimental_small_molecule <- small_molecule$AddChild("Experimental")
illicit_small_molecule <- small_molecule$AddChild("Illicit")
investigational_small_molecule <- small_molecule$AddChild("Investigational")
nutraceutical_small_molecule <- small_molecule$AddChild("Nutraceutical")
withdrawn_small_molecule <- small_molecule$AddChild("Withdrawn")

## level 2
bio_tech <- drug$AddChild("Bio Tech")
### level 3
approved_bio_tech <- bio_tech$AddChild("Approved")
approved_vet_bio_tech <- bio_tech$AddChild("Vet Approved")
experimental_bio_tech <- bio_tech$AddChild("Experimental")
illicit_bio_tech <- bio_tech$AddChild("Illicit")
investigational_bio_tech <- bio_tech$AddChild("Investigational")
nutraceutical_bio_tech <- bio_tech$AddChild("Nutraceutical")
withdrawn_bio_tech <- bio_tech$AddChild("Withdrawn")

# biotech_years <- drugs %>% filter(type == "biotech") %>% select(create_year) %>% distinct()
# for (year in biotech_years$create_year) {
#   bio_tech$AddChild(year)
# }

# small_molecule_years <- drugs %>% filter(type == "small molecule") %>% select(create_year) %>% distinct()
# for (year in small_molecule_years$create_year) {
#   small_molecule$AddChild(year)
# }
# small_molecule$children[[1]]$name
print(drug)
plot(drug)

## add months level and other levels
