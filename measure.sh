#!/bin/bash

# Some setup
LC_NUMERIC=C LC_COLLATE=C

# Default number of speed runs:
iterations=10

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

# Run the test `iterations` times and show execution times.
# Takes the test case as input, returns 0 if successfull.
function run_speed() {
    local min=0 max=0 sum=0 avg mem
    # local s_time e_time

    # Get script to run, ch to its dir
    cd $(dirname "${1}")
    script=./$(basename "${1}")

    printf "%-60s" ${1}

    # printf ' %.0s' {1..48}
    for i in $(seq 1 ${iterations}); do
        printf "%3u/%-3u" ${i} ${iterations}

        # Run test and measure time and memory.
        # This is where the actual script is being run.
        # Its output is immediately captured for processing.
        # s_time=`date +%s%N`
        script_out=`/usr/bin/time -v ${script} 2>&1`
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
        avg=`echo "scale=3;${sum}/${iterations}" | bc`

        printf "% 10.3fs " ${min}
        printf "% 10.3fs " ${max}
        printf "% 10.3fs " ${avg}

        # Format memory needs for nice output.
        mem=`echo ${script_out} | sed "s/.*Maximum resident set size .kbytes.: \([0-9]*\).*/\1/g"`
        mem=`echo "scale=3;${mem}/1024" | bc`
        printf "% 10.3fMb\n" ${mem}
        # echo "Mem: $(( ${mem_out} / 1024 )) Mb"
    else
        echo "Fail!"
    fi

    # Change back to prev dir.
    cd - > /dev/null

    return ${success}
}

echo "Start: `date`"
echo
echo "Command                                                          Min         Max         Avg         Mem"

# Run either all know scripts, or the one provided.
if [ $# -eq 0 ] ; then

    run_speed ape/pairwise_patristic.R
    run_speed ape/read_newick.R
    
    run_speed biopy/base_frequencies.py
    run_speed biopy/read_fasta.py
    
    run_speed dendropy/pairwise_patristic.py
    run_speed dendropy/read_newick.py
    
    #run_speed ete3/pairwise_patristic.py
    run_speed ete3/read_newick.py
    
    run_speed genesis/base_frequencies.sh
    run_speed genesis/pairwise_patristic.sh
    run_speed genesis/read_fasta.sh
    run_speed genesis/read_newick.sh
    
    run_speed ggtree/read_newick.R
    
    run_speed libpll/read_newick.sh
    
else
    run_speed ${1}
fi

echo
echo "End: `date`"
