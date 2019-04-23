#!/bin/bash

rm -f genesis/apps/*.cpp
cp *.cpp genesis/apps
cd genesis
make -j 4
make update -j 4
cd ..
