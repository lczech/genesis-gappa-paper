For storage reasons, we do not keep the test files here,
but instead provide scripts to automatically generate random input files of certain sizes.
As we are only interested in speed measurements, random files work for us here.

The scripts require [gappa](https://github.com/lczech/gappa) to be available from the directory.
The simplest way is to create a symlink here to the gappa binary.
Then, call `generate_data.sh` to generate random trees, alignments, and placement files.
