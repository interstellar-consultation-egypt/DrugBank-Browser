replace_space_with_underscore <- function(name) {
  return(gsub(" ", "_", name))
}

construct_file_name <- function(name, parent = "") {
  if (parent == "") {
    return(paste0(name, ".csv"))
  }
  return(paste0(name, parent, ".csv"))
}

get_dataset_full_path <- function(node, parent) {
  node_name <- replace_space_with_underscore(node)
  full_name <- construct_file_name(node, parent)
  full_path <- paste0("./data/", full_name)
  return(full_path)
}

get_drugs <- function(data) {
  data$`DrugBank ID` <-
    paste0(
      "<a href=\"https://www.drugbank.ca/drugs/",
      data$`DrugBank ID`,
      "\">",
      data$`DrugBank ID`
    )
  data$`FDA Label` <- paste0("<a href=",
                             data$`FDA Label`, "\">",
                             data$`FDA Label`)
  data$MSDS <- paste0("<a href=",
                             data$MSDS, "\">",
                             data$MSDS)
  data$State <- as_factor(data$State)
  data$Type <- as_factor(data$Type)
  return(data)
}

hidden_columns <- list("Drugs" = c(1, 2, 5, 7:9, 11, 13:25))
abbriviated_columns <- list("Drugs" = c(7, 11:16, 19, 20, 23, 24))

## for descriptive and export 
## library("datadigest")
## codebook(data = deugs)