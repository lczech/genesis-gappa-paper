#!/usr/bin/env python

import os
import sys
import time
from Bio import SeqIO
from Bio import AlignIO

# Get data
fastafile=sys.argv[1]
print "reading", fastafile

# Start the clock
start = time.time()

# Run run run!
records =  list( SeqIO.parse( fastafile, "fasta" ) )

# We also tried to read them using the alternative AlinIO,
# but it is significantly slower, 
# so we stay fair and use the faster SeqIO instead.
#records =  list( AlignIO.parse( fastafile, "fasta" ) )[0]

# Stop the clock
end = time.time()
print "Internal time: ", end - start

# Check the output
print len(records)

