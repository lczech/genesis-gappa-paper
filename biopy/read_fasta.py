#!/usr/bin/env python

import os
import sys
import time
from Bio import SeqIO

# Get data
fastafile=sys.argv[1]
print "reading", fastafile

# Start the clock
start = time.time()

# Run run run!
records =  list( SeqIO.parse( fastafile, "fasta" ) )

# Stop the clock
end = time.time()
print "Internal time: ", end - start
