#!/bin/bash

mkdir -p squash
rm squash/*

START=$(date +%s.%N)
echo "Start `date`"

./gappa analyze squash --threads 1 --allow-file-overwriting --tree-file-prefix squash_ --write-newick-tree --out-dir squash --jplace-path $1 > squash/squash.log 2>&1

END=$(date +%s.%N)
DIFF=$(echo "$END - $START" | bc)

echo "End `date`"
echo "Internal time: ${DIFF}"
