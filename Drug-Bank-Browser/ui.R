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
library(DT)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Drug Bank Browser"),
  
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
      tags$br()
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      collapsibleTreeOutput("plot"),
      dataTableOutput("drugs")
    )
  )
))
