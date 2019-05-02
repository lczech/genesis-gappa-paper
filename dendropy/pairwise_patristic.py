#!/usr/bin/env python3

from dendropy import Tree
import os
import sys
import time

# Get input
treefile=sys.argv[1]
print( "reading", treefile )
t = Tree.get( path=treefile, schema="newick" )

# Start the clock
start = time.time()

# Run run run
pdc = t.phylogenetic_distance_matrix()

# Stop the clock
end = time.time()
print("Internal time:", end - start)

# Result check
print(len(pdc._taxon_phylogenetic_distances))
