#!/usr/bin/env Rscript

library(ape)

# Get input tree
args <- commandArgs(trailingOnly = TRUE)
treefile <- args[1]
print(paste("reading ",treefile))

# Read tree. Not part of this measurement.
tree <- read.tree(treefile)

# Get start time
start <- Sys.time()
#print(start)

# Order them the way we want.
tree = reorder(tree, "postorder")

# Some tests
#rev(tree$tip.label)
#tree$tip.label
#write.table( tree$tip.label, "names.txt" )

# Print the taxa to a file
fileConn<-file("names.txt")
writeLines( tree$tip.label, fileConn )
close(fileConn)

# Get end time
end <- Sys.time()
#print(end)

# Print duration
duration <- difftime(end, start, units="secs")
print(paste("Internal time:", duration))
