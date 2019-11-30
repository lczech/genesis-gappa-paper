#!/bin/bash

LANG=/usr/lib/locale/en_US

mkdir -p kr
rm kr/*

START=$(date +%s.%N)
echo "Start `date`"

./guppy kr --out-dir kr -o out $1/* > kr/kr.log 2>&1
#./guppy kr $1/* > kr.log 2>&1

END=$(date +%s.%N)
DIFF=$(echo "$END - $START" | bc)

echo "End `date`"
echo "Internal time: ${DIFF}"
