# col names
# drug id link
# Column Rendering: description abbriviation
# search options:
## https://rstudio.github.io/DT/007-search.html
# cell formats:
## https://rstudio.github.io/DT/functions.html
# buttons:
## https://rstudio.github.io/DT/extensions.html
library(tidyverse)
library(htmlwidgets)
source("Drug_Structure_Tree_Builder.R", local = TRUE)
source("UtilityFunctions.R", local = TRUE)

drugs_tree <- build_drug_bank_tree()

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  output$radial_drug <- renderRadialNetwork({
    drug_radial_network <-  radialNetwork(
      ToListExplicit(drugs_tree, unname = TRUE),
      linkColour = "#ccc",
      nodeColour = "#fff",
      nodeStroke = "orange",
      textColour = "#cccccc"
    )
    onRender(drug_radial_network,
             clickJS)
  })
  
  data <- reactive({
    req(input$name)
    selected_node <- input$name
    full_path <- get_dataset_full_path(selected_node, input$parent)
    data <- read_csv(full_path)
    switch(selected_node,
           "Drugs" = get_drugs(data),
           data)
    
  })
  output$drug_table <- renderDataTable({
    return(datatable(
      data(), 
      style = 'bootstrap',
      rownames = FALSE,
      filter = 'top',
      options = list(
        pageLength = 5,
        autoWidth = TRUE)))
  })
})  