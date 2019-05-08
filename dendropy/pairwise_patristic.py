#!/usr/bin/env python3

import os
import sys
import time

from dendropy import Tree
#from dendropy import treecalc

# Get input
treefile=sys.argv[1]
print( "reading", treefile )
t = Tree.get( path=treefile, schema="newick" )

# Start the clock
start = time.time()

# Run run run
pdc = t.phylogenetic_distance_matrix()
# See https://dendropy.org/library/phylogeneticdistance.html

# Previous versions of dendropy used this:
#pdc = treecalc.PatristicDistanceMatrix(t)


# Stop the clock
end = time.time()
print("Internal time:", end - start)

# Result check
print(len(pdc._taxon_phylogenetic_distances))

