library(tidyverse)
drugs_names <- read_csv(file = "data/drugs.csv")
drugs_names <- drugs$name
write(drugs_names, "data//drugs_names.csv")
drugs <- read_csv("data//drugs_names.csv", col_names = "name")
