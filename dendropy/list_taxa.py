#!/usr/bin/env python3

from dendropy import Tree
import os
import sys
import time


t = Tree.get( path="../data/ben_random_tree_1mio.nw", schema="newick" )

start = time.time()
with open("names.txt", "w+") as outfile:
  for node in t.preorder_node_iter():
    if node.label:
      outfile.write(node.label + "\n")
end = time.time()
print( "Internal time: ", end - start )