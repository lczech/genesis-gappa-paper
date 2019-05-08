#!/bin/bash

rm -f genesis/apps/*.cpp
cp src/*.cpp genesis/apps
cd genesis
make -j 4
make update -j 4
cd ..

for c in `ls src/*.cpp` ; do

	c=${c#src/}
	c=${c%.cpp}
	#echo "linking $c"
	ln -sf genesis/bin/apps/${c} ${c}

done
