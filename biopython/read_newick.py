#!/usr/bin/env python

import os
import sys
import time

from Bio import Phylo

# Get data
infile=sys.argv[1]
print "reading", infile

# Start the clock
start = time.time()

# Run run run!
tree = Phylo.read(infile, "newick")

# Stop the clock
end = time.time()
print "Internal time: ", end - start

# Check the output
print "leaf nodes", len(tree.get_terminals())

