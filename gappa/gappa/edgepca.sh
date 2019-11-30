#!/bin/bash

mkdir -p edgepca
rm edgepca/*

START=$(date +%s.%N)
echo "Start `date`"

./gappa analyze edgepca --threads 1 --allow-file-overwriting --out-dir edgepca --jplace-path $1 > edgepca/edgepca.log 2>&1

END=$(date +%s.%N)
DIFF=$(echo "$END - $START" | bc)

echo "End `date`"
echo "Internal time: ${DIFF}"
