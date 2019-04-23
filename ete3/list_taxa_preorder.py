#!/usr/bin/env python

from ete3 import Tree
import os
import sys
import time


t = Tree( "../data/ben_random_tree_1mio.nw" )

start = time.time()
with open("names.txt", "w+") as outfile:
  for node in t.traverse("preorder"):
    if node.name:
      outfile.write(node.name + "\n")
end = time.time()
print "Internal time: ", end - start