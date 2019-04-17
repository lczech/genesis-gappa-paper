#!/usr/bin/env Rscript 

library(ape)

start <- Sys.time() # get start time
#print(start) 

#treefile <- "../data/ben_random_tree_100k.nw"
treefile <- "../data/ben_random_tree_1mio.nw"
#print(paste("reading ",treefile))

# tree <- read.tree("../data/ben_random_tree_100k.nw")
tree <- read.tree(treefile)

duration <- Sys.time() - start 
print(paste("Internal time:", duration))
