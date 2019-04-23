#!/bin/bash

START=$(date +%s.%N)
echo "Start `date`"

#./guppy check ../data/sample_0_all_big.jplace
./guppy info ../data/sample_0_all_big.jplace

END=$(date +%s.%N)
DIFF=$(echo "$END - $START" | bc)

echo "End `date`"
echo "Internal time: ${DIFF}"
