#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(collapsibleTree)
require(colorspace)
# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Old Faithful Geyser Data"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      selectInput(
        "hierarchy", "Tree hierarchy",
        choices = c(
          "created_year", "created_month", "group", "state"
        ),
        selected = c("group", "state"),
        multiple = TRUE
      ),
      #tags$p("The node you most recently clicked:"),
      #verbatimTextOutput("str"),
      tags$br()
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      collapsibleTreeOutput("plot"),
      dataTableOutput("drugs")
    )
  )
))
