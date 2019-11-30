#!/bin/bash

mkdir -p jplace

# Generate 10k random jplace files
for s in `seq 1 10000` ; do

	#echo "At file $s"
	./gappa random random-placements --reference-tree ../../data/newick/random-tree-1000.newick --pquery-count 1000 > /dev/null
	mv "random-placements.jplace" "jplace/placements-${s}.jplace"

done

# For the gappa/guppy comparison, we run tests that need multiple jplace files as input.
# Hence, generate directories with subsets of different size for each test.
# We use subdirs here to keep the executing test scripts simple (they can just take the whole dir as argument),
# while using symlinks avoids too much disk waste.
for s in 10 20 50 100 200 500 1000 2000 5000 10000; do
	mkdir jplace_${s}
	cd jplace_${s}
	for i in `seq 1 $s` ; do
		ln -s ../jplace/placements-${i}.jplace placements-${i}.jplace
	done
	cd ..
done

