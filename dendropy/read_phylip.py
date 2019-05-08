#!/usr/bin/env python3

import os
import sys
import time

import dendropy

# Get input
infile=sys.argv[1]
print( "reading", infile )

# Start the clock
start = time.time()

# Run run run
d = dendropy.DnaCharacterMatrix.get( path=infile, schema="phylip" )

# Stop the clock
end = time.time()
print( "Internal time:", end - start )

# Check output
print( "sequences", len(d) )
