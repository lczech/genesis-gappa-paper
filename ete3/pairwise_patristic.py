#!/usr/bin/env python

from ete3 import Tree
import os
import sys
import time

# Get input
treefile=sys.argv[1]
print "reading",treefile
t = Tree( treefile )

# Start the clock
start = time.time()

# Run run run
leaves = t.get_leaves()
for n1 in xrange(len(leaves)):
    for n2 in xrange(n1+1, len(leaves)):
        t.get_distance(leaves[n1], leaves[n2])

# Stop the clock
end = time.time()
print("Internal time: ", end - start)
