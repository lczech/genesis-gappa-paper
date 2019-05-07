#!/bin/bash

mkdir -p fasta
mkdir -p phylip

for s in 1000 2000 5000 10000 20000 50000 100000 200000 500000 1000000 ; do

	echo "At size $s"
	./gappa prepare random-alignment --sequence-count $s --sequence-length 1000 --write-fasta --write-strict-phylip > /dev/null
	mv "random-alignment.fasta" "fasta/random-alignment-${s}.fasta"
	mv "random-alignment.phylip" "phylip/random-alignment-${s}.phylip"

done
