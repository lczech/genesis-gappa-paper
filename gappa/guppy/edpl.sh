#!/bin/bash

LANG=/usr/lib/locale/en_US

mkdir -p edpl
rm edpl/*

START=$(date +%s.%N)
echo "Start `date`"

./guppy edpl --out-dir edpl -o out $1 > edpl/edpl.log 2>&1
#./guppy edpl $1 > edpl.log 2>&1

END=$(date +%s.%N)
DIFF=$(echo "$END - $START" | bc)

echo "End `date`"
echo "Internal time: ${DIFF}"
