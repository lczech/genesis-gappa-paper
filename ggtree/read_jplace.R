#!/usr/bin/env Rscript 

#library(tidyverse)
library(ggtree)

#jplacefile <- "/home/lucas/Projects/gappa_tests/04_samples/p1z1r2.jplace"
#jplacefile <- "/home/lucas/Projects/gappa_tests/03_epa/chunk_0/RAxML_portableTree.chunk_0.jplace"
jplacefile <- "../data/sample_0_all_big.jplace"

print(jplacefile)

start <- Sys.time()
print(start) 

#jpf <- system.file(jplacefile, package="ggtree")
jp <- read.jplace(jplacefile)

end <- Sys.time()
print(end) 
duration <- difftime(end, start, units="secs")
print(paste("Internal time:", duration))
print(duration)

print(jp)
