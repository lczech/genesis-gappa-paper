#!/usr/bin/env python

from ete3 import Tree
import os
import sys
import time


start = time.time()
t = Tree( "../data/ben_random_tree_1mio.nw" )
end = time.time()
print "Internal time: ", end - start