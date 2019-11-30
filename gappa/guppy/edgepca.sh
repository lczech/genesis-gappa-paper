#!/bin/bash

LANG=/usr/lib/locale/en_US

mkdir -p edgepca
rm edgepca/*

START=$(date +%s.%N)
echo "Start `date`"

./guppy epca --out-dir edgepca --prefix edgepca $1/* > edgepca/epca.log 2>&1
#./guppy epca $1/* > edgepca/epca.log 2>&1

END=$(date +%s.%N)
DIFF=$(echo "$END - $START" | bc)

echo "End `date`"
echo "Internal time: ${DIFF}"
