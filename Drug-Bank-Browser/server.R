library(shiny)
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
  
  output$text <- renderPrint({
    node_name <- replace_space_with_underscore(input$name)
    full_name <- construct_file_name(node_name, input$parent)
    return(full_name)
  })
})  