#!/usr/bin/env python3

from dendropy import Tree
import os
import sys
import time

t = Tree.get( path="../data/Bact_Unconstr_backbone.newick", schema="newick" )

start = time.time()
pdc = t.phylogenetic_distance_matrix()
end = time.time()
print(len(pdc._taxon_phylogenetic_distances))
print("Internal time: ", end - start)