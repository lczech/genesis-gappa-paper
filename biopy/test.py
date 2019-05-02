#!/usr/bin/env python

import os
import sys
import time
from Bio import SeqIO
from Bio.SeqUtils import GC
from Bio.Align import AlignInfo
from Bio.Align import *
from Bio import AlignIO
from Bio.Alphabet import IUPAC, Gapped

fastafile=sys.argv[1]

print "reading", fastafile
align = AlignIO.read(fastafile, "fasta")

summary=AlignInfo.SummaryInfo(align)
print "done"
#print summary._get_letter_freqs()

info_content = summary.information_content( chars_to_ignore = ['N', '.', '-'])
