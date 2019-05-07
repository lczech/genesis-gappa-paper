#!/usr/bin/env python3

import os
import sys
import time

from skbio import TreeNode

# Get input
treefile=sys.argv[1]
print( "reading", treefile )
tree = TreeNode.read( treefile )

# Start the clock
start = time.time()

# Run run run
pdc = tree.tip_tip_distances()

# Stop the clock
end = time.time()
print( "Internal time:", end - start )

# Check result
print("distances", pdc.shape )
