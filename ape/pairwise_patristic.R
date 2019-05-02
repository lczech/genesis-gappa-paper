#!/usr/bin/env Rscript

library(ape)

# Get input tree file and read it (not part of this measurement)
args <- commandArgs(trailingOnly = TRUE)
treefile <- args[1]
print(paste("reading ",treefile))
tree <- read.tree(treefile)

# Start the clock
start <- Sys.time()

# Run, Forrest, Run!
mat <- cophenetic(tree)

# Stop the clock
end <- Sys.time()
duration <- difftime(end, start, units="secs")
print(paste("Internal time:", duration))

# Check the output
print(dim(mat))
#write.table( mat, "dist_mat.csv", row.names = FALSE, col.names = FALSE )
