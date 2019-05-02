#!/usr/bin/env python

from ete3 import Tree
import os
import sys
import time

# Get input
treefile=sys.argv[1]
print "reading", treefile
t = Tree( treefile )

# Start the clock
start = time.time()

# Run run run
with open("names.txt", "w+") as outfile:
    for node in t.traverse("preorder"):
        if node.name:
            outfile.write(node.name + "\n")

# Stop the clock
end = time.time()
print "Internal time:", end - start
