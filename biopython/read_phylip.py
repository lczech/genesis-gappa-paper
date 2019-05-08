#!/usr/bin/env python

import os
import sys
import time
from Bio import SeqIO
from Bio import AlignIO

# Get data
phylipfile=sys.argv[1]
print "reading", phylipfile

# Start the clock
start = time.time()

# Run run run!
records = list( SeqIO.parse( phylipfile, "phylip" ) )

# We also tried to read them using the alternative AlinIO,
# but it is significantly slower, 
# so we stay fair and use the faster SeqIO instead.
#records =  list( AlignIO.parse( phylipfile, "phylip" ) )[0]

# Stop the clock
end = time.time()
print "Internal time: ", end - start

# Check the output
print len(records)

