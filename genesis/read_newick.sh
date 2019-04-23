#!/bin/bash

./genesis/bin/apps/read_newick ../data/ben_random_tree_1mio.nw

#valgrind --tool=massif ./genesis/bin/apps/newick_info ../data/ben_random_tree_1mio.nw
