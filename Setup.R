library(dbparser)
library(tidyverse)
get_xml_db_rows("D:\\DS Projects\\Drug_Interaction\\drugbank.xml")
drugbank <- parse_drug_all()
drug_df_writer <- function(x, name){
  write_csv(x, file.path(getwd(), paste0(name, "csv")))
}

for(i in 1:length(drugbank)){
  drug_df_writer(drugbank[[i]], names(drugbank)[[i]])
}

