#!/bin/bash

# Get script to run, ch to its dir
cd $(dirname "${1}")
script=./$(basename "${1}")

# Default number of speed runs:
iterations=3

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

    # printf ' %.0s' {1..48}
    for i in $(seq 1 ${iterations}); do
        printf "%3u/%-3u" ${i} ${iterations}

        # Run test and measure time and memory.
        # This is where the actual script is being run.
        # Its output is immediately captured for processing.
        # s_time=`date +%s%N`
        time_out=`/usr/bin/time -v ${1} 2>&1 >/dev/null`
        success=$?
        # e_time=`date +%s%N`

        # Set timing counters.
        # duration=`echo "scale=3;(${e_time} - ${s_time})/(10^06)" | bc`
        # duration=`echo ${time_out} | grep "User time (seconds):" | sed "s/.* \([0-9]*\)\$/\1/g"`
        duration=`echo ${time_out} | sed "s/.*User time .seconds.: \([0-9.]*\).*/\1/g"`
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

        # Break if the test failed. We do not need to repeat it then.
        if [[ ${success} != 0 ]]; then
            break
        fi
    done
    printf ' %.0s'  {1..7}
    printf '\b%.0s' {1..7}
    # printf '\b%.0s' {1..48}

    # Print execution time summaries.
    if [[ ${success} == 0 ]]; then
        avg=`echo "scale=3;${sum}/${iterations}" | bc`

        printf "Min: % 10.3fs\n" ${min}
        printf "Max: % 10.3fs\n" ${max}
        printf "Avg: % 10.3fs\n" ${avg}

        # Format memory needs for nice output.
        mem=`echo ${time_out} | sed "s/.*Maximum resident set size .kbytes.: \([0-9]*\).*/\1/g"`
        mem=`echo "scale=3;${mem}/1024" | bc`
        printf "Mem: % 10.3fMb\n" ${mem}
        # echo "Mem: $(( ${mem_out} / 1024 )) Mb"
    else
        echo "Fail!"
    fi

    return ${success}
}

echo "Start: `date`"
echo "Command: ${script}"
echo

run_speed ${script}

echo
echo "End: `date`"

# Change back to prev dir.
cd -
