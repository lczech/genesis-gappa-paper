#!/usr/bin/env python

from ete3 import Tree
import os
import sys
import time

t = Tree("../data/Bact_Unconstr_backbone.newick")

start = time.time()
leaves = t.get_leaves()
for n1 in xrange(len(leaves)):
  for n2 in xrange(n1+1, len(leaves)):
    t.get_distance(leaves[n1], leaves[n2])
end = time.time()
print "Internal time: ", end - start