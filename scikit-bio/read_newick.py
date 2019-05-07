#!/usr/bin/env python3

import os
import sys
import time

from skbio import TreeNode

# Get input
treefile=sys.argv[1]
print( "reading", treefile )

# Start the clock
start = time.time()

# Run run run
tree = TreeNode.read( treefile )

# Stop the clock
end = time.time()
print( "Internal time:", end - start )

# Check result
print( "tree tips", tree.count(True) )
