# genesis-gappa-paper
Scripts and tests for the Application Note

> Genesis and Gappa: Processing, Analyzing and Visualizing Phylogenetic (Placement) Data.<br />
> Lucas Czech, Pierre Barbera, and Alexandros Stamatakis.<br />
> bioRxiv, 2019. https://doi.org/10.1101/647958<br />

The application note presents our library [genesis](https://github.com/lczech/genesis) and our toolkit [gappa](https://github.com/lczech/gappa). The scripts and tests provided here are used for evaluating runtime and memory of genesis for some typical tasks, in comparison to other bioinformatics libraries with similar functionality.

## Test Cases

Sequence Test Cases:

 - `read_fasta`: Read large files in fasta format
 - `read_phylip`: Read large files in phylip format
 - `base_frequencies`: Calculate the character frequencies of a set of sequences
 
Tree Test Cases:

 - `read_newick`: Read large trees in newick format
 - `pairwise_patristic`: Calculate the pairwise patristic distance matrix between nodes in a tree

Jplace Test Cases:

 - `read_jplace`: Reading large jplace files

## Software

In order to run the tests, the following software is required:

 - [genesis 0.22.1](https://github.com/lczech/genesis)
 - [ape 5.3](https://cran.r-project.org/web/packages/ape/index.html)
 - [Biopython 1.73](https://biopython.org/)
 - [DendroPy 4.4.0](https://dendropy.org/)
 - [ete3 3.1.1](http://etetoolkit.org/)
 - [ggtree 1.10.5](https://github.com/GuangchuangYu/ggtree)
 - [guppy 1.1.a19](http://matsen.github.io/pplacer/generated_rst/guppy.html)
 - [libpll/pll-modules 2019-04-13](https://github.com/ddarriba/pll-modules)
 - [scikit-bio 0.5.5](http://scikit-bio.org/)
 
These are the tools that we compare against in the application note. See there for details.
