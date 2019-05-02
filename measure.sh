#!/bin/bash

# Some setup. Need this for accuracy calculations using `bc`,
# which otherwise might not work on eg German computers with "," being the decimal separator...
LC_NUMERIC=C
LC_COLLATE=C

# Default number of speed runs:
ITERATIONS=5

# This script needs some programs.
if [ -z "`which bc`" ] ; then
    echo "Program 'bc' not found. Cannot run this script."
    exit
fi
if [ -z "`which /usr/bin/time`" ] ; then
    # We cannot use normal `time` on Ubuntu, as it is a wrapper that does not have the -v option.
    # Need to run the underlying program instead.
    echo "Program '/usr/bin/time' not found. Cannot run this script."
    exit
fi

# Run the test `ITERATIONS` times and show execution times.
# Takes the test case as input, returns 0 if successfull.
function run_tests() {
    local min=0 max=0 sum=0 avg mem
    # local s_time e_time

    # Get script to run, ch to its dir
    SCRIPT=${1}
    cd $(dirname "${1}")
    SCRIPT_NAME=./$(basename "${1}")

    # Get the data set to run
    DATA="../${2}"
    DATA_NAME=$(basename "${2}")

    # Get file size
    FILESIZE=`stat --printf="%s" ${DATA}`
    FILESIZE=`ls -lah ${DATA} | awk -F " " {'print $5'}`b

    # Print the line
    printf "%-40s%-40s%15s" ${SCRIPT} ${DATA_NAME} ${FILESIZE}
    # printf ' %.0s' {1..48}

    for i in $(seq 1 ${ITERATIONS}); do
        printf "%3u/%-3u" ${i} ${ITERATIONS}

        # Run test and measure time and memory.
        # This is where the actual script is being run.
        # Its output is immediately captured for processing.
        # s_time=`date +%s%N`
        script_out=`/usr/bin/time -v ${SCRIPT_NAME} ${DATA} 2>&1`
        success=$?
        # e_time=`date +%s%N`

        # Break if the test failed. We do not need to repeat it then.
        if [[ ${success} != 0 ]]; then
            break
        fi

        # Set timing counters.
        # duration=`echo "scale=3;(${e_time} - ${s_time})/(10^06)" | bc`
        # duration=`echo ${script_out} | grep "User time (seconds):" | sed "s/.* \([0-9]*\)\$/\1/g"`
        # duration=`echo ${script_out} | sed "s/.*User time .seconds.: \([0-9.]*\).*/\1/g"`
        duration=`echo ${script_out} | sed "s/.*Internal time: \([0-9.]*\).*/\1/g"`
        if [[ ${max} == 0 ]]; then
            min=${duration}
            max=${duration}
        else
            if [[ `echo "${duration} > ${max}" | bc` == 1 ]]; then
                max=${duration}
            fi
            if [[ `echo "${duration} < ${min}" | bc` == 1 ]]; then
                min=${duration}
            fi
        fi
        sum=`echo "${sum} + ${duration}" | bc`
        printf "\b\b\b\b\b\b\b"
    done
    printf ' %.0s'  {1..7}
    printf '\b%.0s' {1..7}
    # printf '\b%.0s' {1..48}

    # Print execution time summaries.
    if [[ ${success} == 0 ]]; then
        avg=`echo "scale=3;${sum}/${ITERATIONS}" | bc`

        printf "% 10.3fs " ${min}
        printf "% 10.3fs " ${max}
        printf "% 10.3fs " ${avg}

        # Format memory needs for nice output.
        mem=`echo ${script_out} | sed "s/.*Maximum resident set size .kbytes.: \([0-9]*\).*/\1/g"`
        mem=`echo "scale=3;${mem}/1024" | bc`
        printf "% 10.3fMb" ${mem}
        # echo "Mem: $(( ${mem_out} / 1024 )) Mb"

        # Use `time` to get alternative measurements of exec time for consistency checks.
        usrt=`echo ${script_out} | sed "s/.*User time .seconds.: \([0-9.]*\).*/\1/g"`
        syst=`echo ${script_out} | sed "s/.*System time .seconds.: \([0-9.]*\).*/\1/g"`
        wallt=`echo ${script_out} | sed "s/.*Elapsed .wall clock. time .h.mm.ss or m.ss.: \([0-9.:]*\).*/\1/g"`

        printf "% 10.3fs " ${usrt}
        printf "% 10.3fs " ${syst}
        printf "% 10s \n" ${wallt}
    else
        echo "Fail!"
    fi

    # Change back to prev dir.
    cd - > /dev/null

    return ${success}
}

function run_fasta() {
    DATA_DIR="data/fasta"

    run_tests $1 "${DATA_DIR}/random-alignment-1000.fasta"
    run_tests $1 "${DATA_DIR}/random-alignment-2000.fasta"
    run_tests $1 "${DATA_DIR}/random-alignment-5000.fasta"
    run_tests $1 "${DATA_DIR}/random-alignment-10000.fasta"
    run_tests $1 "${DATA_DIR}/random-alignment-20000.fasta"
    run_tests $1 "${DATA_DIR}/random-alignment-50000.fasta"
    run_tests $1 "${DATA_DIR}/random-alignment-100000.fasta"
    run_tests $1 "${DATA_DIR}/random-alignment-200000.fasta"
    run_tests $1 "${DATA_DIR}/random-alignment-500000.fasta"
    run_tests $1 "${DATA_DIR}/random-alignment-1000000.fasta"
}

function run_phylip() {
    DATA_DIR="data/phylip"

    run_tests $1 "${DATA_DIR}/random-alignment-1000.phylip"
    run_tests $1 "${DATA_DIR}/random-alignment-2000.phylip"
    run_tests $1 "${DATA_DIR}/random-alignment-5000.phylip"
    run_tests $1 "${DATA_DIR}/random-alignment-10000.phylip"
    run_tests $1 "${DATA_DIR}/random-alignment-20000.phylip"
    run_tests $1 "${DATA_DIR}/random-alignment-50000.phylip"
    run_tests $1 "${DATA_DIR}/random-alignment-100000.phylip"
    run_tests $1 "${DATA_DIR}/random-alignment-200000.phylip"
    run_tests $1 "${DATA_DIR}/random-alignment-500000.phylip"
    run_tests $1 "${DATA_DIR}/random-alignment-1000000.phylip"
}

function run_newick() {
    DATA_DIR="data/newick"

    run_tests $1 "${DATA_DIR}/random-tree-1000.newick"
    run_tests $1 "${DATA_DIR}/random-tree-2000.newick"
    run_tests $1 "${DATA_DIR}/random-tree-5000.newick"
    run_tests $1 "${DATA_DIR}/random-tree-10000.newick"
    run_tests $1 "${DATA_DIR}/random-tree-20000.newick"
    run_tests $1 "${DATA_DIR}/random-tree-50000.newick"
    run_tests $1 "${DATA_DIR}/random-tree-100000.newick"
    run_tests $1 "${DATA_DIR}/random-tree-200000.newick"
    run_tests $1 "${DATA_DIR}/random-tree-500000.newick"
    run_tests $1 "${DATA_DIR}/random-tree-1000000.newick"
}

function run_jplace() {
    DATA_DIR="data/jplace"

    run_tests $1 "${DATA_DIR}/random-placements-1000.jplace"
    run_tests $1 "${DATA_DIR}/random-placements-2000.jplace"
    run_tests $1 "${DATA_DIR}/random-placements-5000.jplace"
    run_tests $1 "${DATA_DIR}/random-placements-10000.jplace"
    run_tests $1 "${DATA_DIR}/random-placements-20000.jplace"
    run_tests $1 "${DATA_DIR}/random-placements-50000.jplace"
    run_tests $1 "${DATA_DIR}/random-placements-100000.jplace"
    run_tests $1 "${DATA_DIR}/random-placements-200000.jplace"
    run_tests $1 "${DATA_DIR}/random-placements-500000.jplace"
    run_tests $1 "${DATA_DIR}/random-placements-1000000.jplace"
}

echo "Start: `date`"
echo
echo "Command                                 Data                                             Size         Min         Max         Avg         Mem        User         Sys        Wall "

# Run either all know scripts, or the one provided.
if [ $# -eq 0 ] ; then

    # Read Newick
	run_newick ape/read_newick.R
    run_newick dendropy/read_newick.py
    run_newick ete3/read_newick.py
    run_newick ggtree/read_newick.R
    run_newick libpll/read_newick.sh
    run_newick genesis/read_newick.sh
    echo

    # Pairwise Patristic
    run_newick ape/pairwise_patristic.R
    run_newick dendropy/pairwise_patristic.py
    #run_newick ete3/pairwise_patristic.py
    run_newick genesis/pairwise_patristic.sh
    echo

    # Read Fasta
    run_fasta biopy/read_fasta.py
    run_fasta genesis/read_fasta.sh
    echo

    # Base Frequencies
    run_fasta biopy/base_frequencies.py
    run_fasta genesis/base_frequencies.sh
    echo

    # Read Jplace
    run_jplace ggtree/read_jplace.R
    run_jplace guppy/read_jplace.sh
    run_jplace genesis/read_jplace.sh

else
    run_tests ${1} ${2}
fi

echo
echo "End: `date`"
