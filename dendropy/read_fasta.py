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
d = dendropy.DnaCharacterMatrix.get( path=infile, schema="fasta" )

# Some other documentation suggested the following.
# Not sure if it is the preferred way. Speed is roughly the same.
#ds = dendropy.DataSet()
#tns = ds.new_taxon_namespace()
#ds.attach_taxon_namespace(tns)
#ds.read( path=infile, schema="fasta", data_type="dna" )

# Stop the clock
end = time.time()
print( "Internal time:", end - start )

# Check output
print( "sequences", len(d) )
