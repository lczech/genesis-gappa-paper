#!/usr/bin/env python3

import os
import sys
import time

from skbio import TabularMSA, DNA

# Get input
phylipfile=sys.argv[1]
print( "reading", phylipfile)

# Start the clock
start = time.time()

# Run run run
msa = TabularMSA.read(phylipfile, format='phylip', constructor=DNA)

# Stop the clock
end = time.time()
print( "Internal time:", end - start )

# Check the result
print( "msa shape", msa.shape )
