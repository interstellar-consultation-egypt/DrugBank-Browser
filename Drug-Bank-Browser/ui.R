library(shinythemes)

dashboardPage(
  dashboardHeader(title = "DrugBank Browser"),
  dashboardSidebar(menuItem("Main", tabName = "main", icon = icon("dashboard")),
                   menuItem("Statistics", tabName = "stats", icon = icon("th"))),
  dashboardBody(
    tabItems(
      tabItem(tabName = "main", 
              radialNetworkOutput("radial_drug")),
      tabItem(tabName = "stats",
              codebookOutput("describe"), height = "100%")
      )
  )
)

# shinyUI(fluidPage(
#   #theme = shinytheme("slate"),
#   # Application title
#   titlePanel("DrugBank Browser"),
#   tabsetPanel(
#     type = "tabs",
#     tabPanel("main",
#              fluidRow(column(
#                width = 12,
#                radialNetworkOutput("radial_drug")
#              )),
#              fluidRow(column(
#                width = 12,
#                dataTableOutput("drug_table")
#                
#              ))),
#     tabPanel("stat",
#              codebookOutput("describe"))
#   )
# ))
