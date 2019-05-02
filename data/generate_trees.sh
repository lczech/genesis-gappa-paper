#!/bin/bash

mkdir -p newick

for s in 1000 2000 5000 10000 20000 50000 100000 200000 500000 1000000 ; do

	echo "At size $s"
	./gappa prepare random-tree --leaf-count $s > /dev/null
	mv "random-tree.newick" "newick/random-tree-${s}.newick"

done
