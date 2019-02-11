replace_space_with_underscore <- function(name) {
  return(gsub(" ", "_", name))
}

construct_file_name <- function(name, parent) {
  if (parent == "") {
    return(name)
  }
  return( paste0(name, parent, ".csv"))
}