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
    full_path <- get_dataset_full_path(input$name, input$parent)
    read_csv(full_path)
  })
  output$drug_table <- renderDataTable({
    return(data())
  })
})  