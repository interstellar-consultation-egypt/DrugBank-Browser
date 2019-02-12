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
  data
}

hidden_columns <- list("Drugs"= c(1,2,5,7:10,11,13:25))