#!/usr/bin/env python

import os
import sys
import time
from Bio import SeqIO

start = time.time()

records =  list( SeqIO.parse( "../data/SILVA_123.1_SSURef_Nr99_tax_silva.fasta", "fasta" ) )

end = time.time()
print "Internal time: ", end - start