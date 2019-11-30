#!/bin/bash

mkdir -p edpl
rm edpl/*

START=$(date +%s.%N)
echo "Start `date`"

./gappa examine edpl --threads 1 --allow-file-overwriting --out-dir edpl --jplace-path $1 > edpl/edpl.log 2>&1

END=$(date +%s.%N)
DIFF=$(echo "$END - $START" | bc)

echo "End `date`"
echo "Internal time: ${DIFF}"
