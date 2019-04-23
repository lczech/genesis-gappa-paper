#!/bin/bash

rm -f names.txt
./genesis/bin/apps/list_taxa_preorder ../data/ben_random_tree_1mio.nw

#valgrind --tool=massif ./genesis/bin/apps/newick_info ../data/ben_random_tree_1mio.nw
