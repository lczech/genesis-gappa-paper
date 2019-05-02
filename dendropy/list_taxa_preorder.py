#!/usr/bin/env python3

from dendropy import Tree
import os
import sys
import time


# Get input
treefile=sys.argv[1]
print "reading",treefile
t = Tree.get( path=treefile, schema="newick" )

# Start the clock
start = time.time()

# Run run run
with open("names.txt", "w+") as outfile:
  for node in t.preorder_node_iter():
    if node.label:
      outfile.write(node.label + "\n")

# Stop the clock
end = time.time()
print("Internal time: ", end - start)
