#!/usr/bin/env python3

import os
import sys
import time

from skbio import TabularMSA, DNA

# Get input
fastafile=sys.argv[1]
print( "reading", fastafile)

# Start the clock
start = time.time()

# Run run run
msa = TabularMSA.read(fastafile, format='fasta', constructor=DNA)

# Stop the clock
end = time.time()
print( "Internal time:", end - start )

# Check the result
print( "msa shape", msa.shape )
