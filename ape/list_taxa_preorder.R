#!/usr/bin/env Rscript 

library(ape)


#print(start) 

#treefile <- "../data/ben_random_tree_100k.nw"
treefile <- "../data/ben_random_tree_1mio.nw"
#print(paste("reading ",treefile))

# tree <- read.tree("../data/ben_random_tree_100k.nw")
tree <- read.tree(treefile)

start <- Sys.time() # get start time

tree = reorder(tree, "postorder")
#rev(tree$tip.label)
#tree$tip.label

#write.table( tree$tip.label, "names.txt" )

fileConn<-file("names.txt")
writeLines( tree$tip.label, fileConn)
close(fileConn)

duration <- Sys.time() - start 
print(paste("Internal time:", duration))
