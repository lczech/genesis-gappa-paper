#!/bin/bash

mkdir -p kr
rm kr/*

START=$(date +%s.%N)
echo "Start `date`"

./gappa analyze krd --threads 1 --allow-file-overwriting --file-prefix kr_ --out-dir kr --jplace-path $1 > kr/kr.log 2>&1

END=$(date +%s.%N)
DIFF=$(echo "$END - $START" | bc)

echo "End `date`"
echo "Internal time: ${DIFF}"
