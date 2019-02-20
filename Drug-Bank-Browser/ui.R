library(shinythemes)
# Define UI for application that draws a histogram
shinyUI(fluidPage(
  #theme = shinytheme("slate"),
  # Application title
  titlePanel("DrugBank Browser"),
  tabsetPanel(
    type = "tabs",
    # tabPanel("main",
    #          fluidRow(column(
    #            width = 12,
    #            radialNetworkOutput("radial_drug")
    #          )),
    #          fluidRow(column(
    #            width = 12,
    #            dataTableOutput("drug_table")
    #            
    #          ))),
    tabPanel("stat",
             codebookOutput("describe"))
  )
))
