#!/bin/bash

rm -f genesis/apps/*.cpp

for c in `ls *.cpp` ; do
	rm -f ${c/.cpp/}
done
