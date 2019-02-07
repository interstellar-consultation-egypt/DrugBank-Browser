library(networkD3)

clickJS <- 'd3.selectAll(".node").on("click", function(d){
parent = "";
depth = d.depth;
current_node = d;
while (depth > 0) {
  parent = parent + ", " + current_node.parent.data.name;
  depth = current_node.parent.depth;
  current_node =  current_node.parent;
}
Shiny.setInputValue("parent", parent);
Shiny.setInputValue("name", d.data.name);
})'