# Download
## https://github.com/rstudio/DT/issues/267
## https://rstudio.github.io/DT/server.html
# Save filters and sorting
## https://stackoverflow.com/questions/43973863/keep-datatable-sort-between-tabs-in-shiny
## https://stackoverflow.com/questions/52858889/extract-filters-from-r-shiny-datatable
## https://stackoverflow.com/questions/44599021/statesave-not-preserving-filters-in-shiny-datatable
## https://stackoverflow.com/questions/27965791/how-to-save-sorting-in-datatable-in-shiny
# cell formats:
## https://rstudio.github.io/DT/functions.html
# buttons:
## https://rstudio.github.io/DT/extensions.html
library(tidyverse)
library(htmlwidgets)
source("Drug_Structure_Tree_Builder.R", local = TRUE)
source("UtilityFunctions.R", local = TRUE)

drugs_tree <- build_drug_bank_tree()

colorVector <- c("black", "red", "blue", "green", "orange", 
                 rep("red", 5), rep("blue", 5), rep("green", 4), rep("orange", 4),
                 rep("red", 11), rep("blue", 14), rep("green", 14), rep("orange", 11))

jsarray <- paste0('["', paste(colorVector, collapse = '", "'), '"]')
nodeStrokeJS <- JS(paste0('function(d, i) { return ', jsarray, '[i]; alert("hi") }'))

MyClickScript <-'alert("You clicked " + d.name + " which is in row " +(d.index + 1) +  " of your original R data frame");'
#clickJS <- 'function(el, x) {d3.selectAll(".node").on("click", function(d){ alert(d.data.name); })}'
# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  output$radial_drug <- renderRadialNetwork({
    drug_radial_network <-  radialNetwork(
      ToListExplicit(drugs_tree, unname = TRUE),
      linkColour = "#ccc",
      nodeColour = "#fff",
      #nodeStroke = "orange",
      textColour = "#cccccc",
      nodeStroke = nodeStrokeJS
    )
    onRender(drug_radial_network, clickJS)
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
      buttons =  list(
        'copy',
        'print',
        list(
          extend = 'collection',
          buttons = c('csv', 'excel', 'pdf'),
          text = 'Download'
        ),
        "colvis"
      ),
      extensions = "Buttons",
      search = list(regex = TRUE, caseInsensitive = FALSE),
      columnDefs = list(
        list(visible = FALSE, targets = hidden_columns[[input$name]]),
        list(
          render = JS(
            "function(data, type, row, meta) {",
            "return type === 'display' && data && data.length > 25 ?",
            "'<span title=\"' + data + '\">' + data.substr(0, 25) + '...</span>' : data;",
            "}"
          ),
          targets = abbriviated_columns[[input$name]]
        )
      )
    )
    
  )
  
  output$describe <- renderCodebook({
    codebook(data = as.data.frame(drugs)[1:100, 4:10])
    
  })
  
})  