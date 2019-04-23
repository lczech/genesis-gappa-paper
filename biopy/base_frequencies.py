#!/usr/bin/env python

import os
import sys
import time
from Bio import SeqIO

fastafile= "../data/SILVA_123.1_SSURef_Nr99_tax_silva.fasta"
# file="../data/10k.fasta"

records =  list( SeqIO.parse( fastafile, "fasta" ) )

start = time.time()

base_freqs = { "A": 0, "C": 0, "G": 0, "T": 0 }
for rec in records:
  base_freqs["A"] += sum(rec.seq.count(x) for x in ['A', 'a'])
  base_freqs["C"] += sum(rec.seq.count(x) for x in ['C', 'c'])
  base_freqs["G"] += sum(rec.seq.count(x) for x in ['G', 'g'])
  base_freqs["T"] += sum(rec.seq.count(x) for x in ['T', 't', 'U', 'u'])

#base_freqs = { x : sum(rec.seq.count(x) for rec in records for x in ['A', 'a', 'C', 'c', 'G', 'g', 'T', 't', 'U', 'u']) }

#print "GC content ratio: ", (gc_count / float(nt_count)) * 100

end = time.time()
print "Internal time: ", end - start

print base_freqs
