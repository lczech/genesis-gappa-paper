#!/bin/bash

mkdir -p jplace

for s in 1000 2000 5000 10000 20000 50000 100000 200000 500000 1000000 ; do

	echo "At size $s"
	./gappa prepare random-placements --reference-tree trees/random-tree-1000.newick --pquery-count $s > /dev/null
	mv "random-placements.jplace" "jplace/random-placements-${s}.jplace"

done

