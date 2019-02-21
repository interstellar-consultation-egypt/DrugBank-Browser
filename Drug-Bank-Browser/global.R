library(shiny)
library(networkD3)
library(DT)
library(tidyverse)
library(datadigest)
library(shinydashboard)
clickJS <- 'function(el, x) {d3.selectAll(".node").on("click", function(d){
parent = "";
depth = d.depth;
current_node = d;
while (depth > 0) {
  parent_name = current_node.parent.data.name;
  depth = current_node.parent.depth;
  current_node =  current_node.parent;
  if (parent_name == "References") {
    continue;
  }
  parent = parent + "_" + parent_name;
}
Shiny.setInputValue("parent", parent);
Shiny.setInputValue("name", d.data.name);
})}'

drugs <- read_csv("data/Drugs.csv")