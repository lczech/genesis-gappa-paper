#!/usr/bin/env Rscript 

library(ape)

# Read the tree
treefile <- "../data/Bact_Unconstr_backbone.newick"
print(paste("reading ",treefile))
tree <- read.tree(treefile)

# Start the clock
start <- Sys.time() 

# Run, Forrest, Run!
mat <- cophenetic(tree)

# Stop the clock
duration <- Sys.time() - start 
print(paste("Internal time:", duration))

# Check the output
print(dim(mat))
#write.table( mat, "dist_mat.csv", row.names = FALSE, col.names = FALSE )

#fileConn<-file("names.txt")
#writeLines( tree$tip.label, fileConn)
#close(fileConn)
