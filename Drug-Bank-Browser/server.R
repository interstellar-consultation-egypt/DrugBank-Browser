library(shiny)
library(networkD3)
source("Drug_Structure_Tree_Builder.R")

drugs_tree <- build_drug_bank_tree()
# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  output$radial_drug <- renderRadialNetwork({
    radialNetwork(ToListExplicit(drugs_tree, unname = TRUE), linkColour = "#ccc",nodeColour = "#fff",
                  nodeStroke = "orange",textColour = "#cccccc")
  })
})