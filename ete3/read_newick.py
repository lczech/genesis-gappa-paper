#!/usr/bin/env python

from ete3 import Tree
import os
import sys
import time

# Get input
treefile=sys.argv[1]
print "reading",treefile

# Start the clock
start = time.time()

# Run run run
t = Tree( treefile )

# Stop the clock
end = time.time()
print("Internal time: ", end - start)
