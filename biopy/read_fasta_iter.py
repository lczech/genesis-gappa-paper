#!/usr/bin/env python

import os
import sys
import time
from Bio import SeqIO

start = time.time()

with open( "../data/SILVA_123.1_SSURef_Nr99_tax_silva.fasta", "rU") as f:
    for seq in SeqIO.parse( f, "fasta" ):
        continue

end = time.time()
print "Internal time: ", end - start