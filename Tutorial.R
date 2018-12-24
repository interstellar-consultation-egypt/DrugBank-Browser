library(collapsibleTree)

collapsibleTree(warpbreaks, c("wool", "tension", "breaks"))
#-----------------------------------------------------------
library(data.tree)

acme <- Node$new("Acme Inc.")
accounting <- acme$AddChild("Accounting")
software <- accounting$AddChild("New Software")
standards <- accounting$AddChild("New Accounting Standards")
research <- acme$AddChild("Research")
newProductLine <- research$AddChild("New Product Line")
newLabs <- research$AddChild("New Labs")
it <- acme$AddChild("IT")
outsource <- it$AddChild("Outsource")
agile <- it$AddChild("Go agile")
goToR <- it$AddChild("Switch to R")

print(acme)
plot(acme)

SetGraphStyle(acme, rankdir = "TB")
SetEdgeStyle(acme, arrowhead = "vee", color = "grey35", penwidth = 2)
SetNodeStyle(acme, style = "filled,rounded", shape = "box", fillcolor = "GreenYellow", 
             fontname = "helvetica", tooltip = GetDefaultTooltip)
SetNodeStyle(acme$IT, fillcolor = "LightBlue", penwidth = "5px")
plot(acme)

SetNodeStyle(acme$Accounting, inherit = FALSE, fillcolor = "Thistle", 
             fontcolor = "Firebrick", tooltip = "This is the accounting department")
plot(acme)

Do(acme$leaves, function(node) SetNodeStyle(node, shape = "egg"))
plot(acme)

library(igraph)
plot(as.igraph(acme, directed = TRUE, direction = "climb"))

library(networkD3)
acmeNetwork <- ToDataFrameNetwork(acme, "name")
simpleNetwork(acmeNetwork[-3], fontSize = 12)

fileName <- system.file("extdata", "useR15.csv", package="data.tree")
useRdf <- read.csv(fileName, stringsAsFactors = FALSE)
#define the hierarchy (Session/Room/Speaker)
useRdf$pathString <- paste("useR", useRdf$session, useRdf$room, useRdf$speaker, sep="|")
#convert to Node
useRtree <- as.Node(useRdf, pathDelimiter = "|")

#plot with networkD3
useRtreeList <- ToListExplicit(useRtree, unname = TRUE)
radialNetwork( useRtreeList)
