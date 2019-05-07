#!/usr/bin/env python3

import os
import sys
import time

from skbio import TabularMSA, DNA

# Get input
fastafile=sys.argv[1]
print( "reading", fastafile)

# Read. Not timed here.
msa = TabularMSA.read(fastafile, format='fasta', constructor=DNA)

# Start the clock
start = time.time()

base_freqs = { "A": 0, "C": 0, "G": 0, "T": 0 }
for seq in msa:
    freqs = seq.frequencies()
    base_freqs["A"] += freqs["A"]
    base_freqs["C"] += freqs["C"]
    base_freqs["G"] += freqs["G"]
    base_freqs["T"] += freqs["T"]

# Stop the clock
end = time.time()
print( "Internal time:", end - start )

# Check the result
print( "frequencies", base_freqs )
