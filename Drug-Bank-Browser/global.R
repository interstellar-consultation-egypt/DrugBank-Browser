clickJS <- 'd3.selectAll(".node").on("click", function(d){
console.log(d);
Shiny.setInputValue("depth", d.depth);
Shiny.setInputValue("parent", d.parent.data.name);
Shiny.setInputValue("name", d.data.name);})'