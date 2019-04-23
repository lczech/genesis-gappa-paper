#!/usr/bin/env python

import os
import sys
import time
from Bio import SeqIO
from Bio.SeqUtils import GC
NT=['G', 'C', 'A', 'T', 'U', 'g', 'c', 'a', 't', 'u']

file= "../data/SILVA_123.1_SSURef_Nr99_tax_silva.fasta"
# file="../data/10k.fasta"

records =  list( SeqIO.parse( file, "fasta" ) )

start = time.time()

gc_count=0
nt_count=0

for rec in records:
  gc_count += sum(rec.seq.count(x) for x in ['G', 'C', 'g', 'c'])
  # nt_count += len(rec.seq)
  nt_count += sum(rec.seq.count(x) for x in NT)

print "GC content ratio: ", (gc_count / float(nt_count)) * 100

end = time.time()
print "Internal time: ", end - start