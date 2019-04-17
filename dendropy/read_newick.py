#!/usr/bin/env python3

from dendropy import Tree
import os
import sys
import time


start = time.time()
t = Tree.get( path="../data/ben_random_tree_1mio.nw", schema="newick" )
end = time.time()
print("Internal time: ", end - start)