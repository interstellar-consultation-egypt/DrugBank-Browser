clickJS <- 'd3.selectAll(".node").on("click", function(d){
Shiny.onInputChange("id", d.data.name);})'