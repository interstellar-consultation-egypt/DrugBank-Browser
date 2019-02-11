library(shiny)
library(shinythemes)
# Define UI for application that draws a histogram
shinyUI(fluidPage(
  theme = shinytheme("slate"),
  # Application title
  titlePanel("DrugBank Browser"),
  
  fluidRow(column(
    width = 12,
    radialNetworkOutput("radial_drug")
  )),
  fluidRow(column(
    width = 12,
    textOutput("text")
  ))
))
