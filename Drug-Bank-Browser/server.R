#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(data.tree)
library(tidyverse)
library(lubridate)
library(forcats)
library(collapsibleTree)
## Read drugs
drugs <- read_csv(file = "../data/drugs.csv")
drugs$type <- as.factor(drugs$type)
drugs$state <-fct_explicit_na(drugs$state, "Unknown") 
## Read Groups
drug_groups <- read_csv("../data/drug_groups.csv")

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
  output$plot <- renderCollapsibleTree({
    drugs %>% 
      select(primary_key, type = type, state, created) %>%
      full_join(drug_groups, by = c("primary_key" = "parent_key")) %>% 
      rename(group = "text") %>% 
      mutate(created_year = year(created), created_month = month(created)) %>% 
      group_by(created_year, created_month, group, state) %>%
      summarize(`Number of Drugs` = n()) %>%
      collapsibleTreeSummary(
        hierarchy = input$hierarchy,
        root = "Drugs",
        inputId = "node",
        width = 800,
        attribute = "Number of Drugs"
      )
  })
  
  output$str <- renderPrint(str(input$node))
  
})
