library(shiny)
library(shinythemes)
# Define UI for application that draws a histogram
shinyUI(fluidPage(
  theme = shinytheme("slate"),
  # Application title
  titlePanel("Drug Bank Browser"),
  
  fluidRow(
    column(width = 12,
           radialNetworkOutput("radial_drug"))
  )
))
