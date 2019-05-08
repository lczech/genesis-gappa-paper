#!/usr/bin/env python

import os
import sys
import time
from Bio import SeqIO

# Get data
fastafile=sys.argv[1]
print "reading", fastafile
records =  list( SeqIO.parse( fastafile, "fasta" ) )

# Start the clock
start = time.time()

# There is a private method that seems to do what we want,
# but unfortunately, it's private, so we cannot use it...
#summary=AlignInfo.SummaryInfo(records)
#print summary._get_letter_freqs()

# Run run run!
base_freqs = { "A": 0, "C": 0, "G": 0, "T": 0 }
for rec in records:
    base_freqs["A"] += sum(rec.seq.count(x) for x in ['A', 'a'])
    base_freqs["C"] += sum(rec.seq.count(x) for x in ['C', 'c'])
    base_freqs["G"] += sum(rec.seq.count(x) for x in ['G', 'g'])
    base_freqs["T"] += sum(rec.seq.count(x) for x in ['T', 't', 'U', 'u'])

# Stop the clock
end = time.time()
print "Internal time: ", end - start

# Result checking
print base_freqs
