#!/bin/bash

rm -f dist_mat.csv

#./genesis/bin/apps/pairwise_patristic ../data/Vascular_Plants_rooted.dated.tre
./genesis/bin/apps/pairwise_patristic ../data/Bact_Unconstr_backbone.newick

#valgrind --tool=massif ./genesis/bin/apps/newick_info ../data/ben_random_tree_1mio.nw
