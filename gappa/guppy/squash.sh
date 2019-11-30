#!/bin/bash

LANG=/usr/lib/locale/en_US

mkdir -p squash
rm squash/*

START=$(date +%s.%N)
echo "Start `date`"

./guppy squash --out-dir squash $1/* > squash/squash.log 2>&1
#./guppy squash $1/* > squash.log 2>&1

END=$(date +%s.%N)
DIFF=$(echo "$END - $START" | bc)

echo "End `date`"
echo "Internal time: ${DIFF}"
