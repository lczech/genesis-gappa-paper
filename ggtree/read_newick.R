#!/usr/bin/env Rscript

#library(tidyverse)
library(ggtree)

# Get input tree file
args <- commandArgs(trailingOnly = TRUE)
treefile <- args[1]
print(paste("reading ",treefile))

# Start the clock
start <- Sys.time()

# Run, Forrest, Run!
tree <- read.tree(treefile)

# Stop the clock
end <- Sys.time()
duration <- difftime(end, start, units="secs")
print(paste("Internal time:", duration))
