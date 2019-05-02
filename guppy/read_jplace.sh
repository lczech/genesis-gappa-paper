#!/bin/bash

START=$(date +%s.%N)
echo "Start `date`"

#./guppy check $1
./guppy info $1

END=$(date +%s.%N)
DIFF=$(echo "$END - $START" | bc)

echo "End `date`"
echo "Internal time: ${DIFF}"
