#!/bin/bash

rm -f genesis/apps/*.cpp
cp *.cpp genesis/apps
cd genesis
make -j 4
make update -j 4
cd ..

for c in `ls *.cpp` ; do

	ln -s genesis/bin/apps/${c/.cpp/} ${c/.cpp/}

done
