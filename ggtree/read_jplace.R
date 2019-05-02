#!/usr/bin/env Rscript

#library(tidyverse)
library(ggtree)

# Get input tree file and read it (not part of this measurement)
args <- commandArgs(trailingOnly = TRUE)
jplacefile <- args[1]
print(paste("reading ",jplacefile))

# Start the clock
start <- Sys.time()

# Run, Forrest, Run!
jp <- read.jplace(jplacefile)

# Stop the clock
end <- Sys.time()
duration <- difftime(end, start, units="secs")
print(paste("Internal time:", duration))

# Check the output
print(jp)
