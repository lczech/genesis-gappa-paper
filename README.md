# genesis-gappa-paper
Scripts and Tests for the Application Note

Tree Test Cases:

 - `read_newick`: Reading in large trees in Newick format, using `ben_random_tree_1mio.nw`
 - `pairwise_patristic`: Calculate the pairwise patristic distance matrix between nodes in a tree, using `Bact_Unconstr_backbone.newick`

Sequence Test Cases:

 - `read_fasta`: Read in or iterate large files in Fasta format, using `SILVA_123.1_SSURef_Nr99_tax_silva.fasta`
 - `gc_content`: Calculate the character frequencies and GC content of a set of sequences, using `SILVA_123.1_SSURef_Nr99_tax_silva.fasta`
