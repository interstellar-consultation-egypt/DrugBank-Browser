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
  output$drug_table <- renderDataTable(
    data(),
    style = "bootstrap",
    escape = FALSE,
    rownames = FALSE,
    filter = "top",
    extensions = "Buttons",
    options = list(
      scrollX = TRUE,
      searchHighlight = TRUE,
      pageLength = 5,
      autoWidth = TRUE,
      dom = "lfrtiBp",
      buttons = c("copy", "excel", "pdf", "print", "colvis"),
      extensions = "Buttons",
      search = list(regex = TRUE, caseInsensitive = FALSE),
      columnDefs = list(
        list(visible = FALSE, targets = hidden_columns[[input$name]]),
        list(render = JS(
          "function(data, type, row, meta) {",
          "return type === 'display' && data && data.length > 25 ?",
          "'<span title=\"' + data + '\">' + data.substr(0, 25) + '...</span>' : data;",
          "}"
        ), targets = abbriviated_columns[[input$name]])
      )
    )
    
  )
})  