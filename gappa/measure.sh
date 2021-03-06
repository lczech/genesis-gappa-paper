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

rm -f measure_time.csv
rm -f measure_memory.csv

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
    DATA_NAME="${2}"
    DATA="${3}"

    # Get file size
    if [ -f "${DATA}" ]; then
        # FILESIZE=`stat --printf="%s" ${DATA}`
        FILESIZE=`ls -lah ${DATA} | awk -F " " {'print $5'}`b
    elif [ -d "${DATA}" ]; then
        FILESIZE=`du -hsL ${DATA} | sed "s/\t.*//g"`b
    else
        echo "${DATA} does not exist"
    fi

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
        # syst=`echo ${script_out} | sed "s/.*System time .seconds.: \([0-9.]*\).*/\1/g"`
        wallt=`echo ${script_out} | sed "s/.*Elapsed .wall clock. time .h.mm.ss or m.ss.: \([0-9.:]*\).*/\1/g"`
        printf "% 10.3fs " ${usrt}
        # printf "% 10.3fs " ${syst}
        printf "% 10s \n" ${wallt}

        # Print to tab files for easier post-processing
        echo -en "\t${min}" >> "../measure_time.csv"
        echo -en "\t${mem}" >> "../measure_memory.csv"
    else
        echo "Fail!"
    fi

    # Change back to prev dir.
    cd - > /dev/null

    return ${success}
}

function run_single_jplace() {
    DATA_DIR="../../data/jplace"

    echo -n "$1" >> "measure_time.csv"
    echo -n "$1" >> "measure_memory.csv"

    run_tests $1 random-placements-1000.jplace      "${DATA_DIR}/random-placements-1000.jplace"
    run_tests $1 random-placements-2000.jplace      "${DATA_DIR}/random-placements-2000.jplace"
    run_tests $1 random-placements-5000.jplace      "${DATA_DIR}/random-placements-5000.jplace"
    run_tests $1 random-placements-10000.jplace     "${DATA_DIR}/random-placements-10000.jplace"
    run_tests $1 random-placements-20000.jplace     "${DATA_DIR}/random-placements-20000.jplace"
    run_tests $1 random-placements-50000.jplace     "${DATA_DIR}/random-placements-50000.jplace"
    run_tests $1 random-placements-100000.jplace    "${DATA_DIR}/random-placements-100000.jplace"
    run_tests $1 random-placements-200000.jplace    "${DATA_DIR}/random-placements-200000.jplace"
    run_tests $1 random-placements-500000.jplace    "${DATA_DIR}/random-placements-500000.jplace"
    run_tests $1 random-placements-1000000.jplace   "${DATA_DIR}/random-placements-1000000.jplace"

    echo >> "measure_time.csv"
    echo >> "measure_memory.csv"
}

function run_multiple_jplace() {
    DATA_DIR="../data"

    echo -n "$1" >> "measure_time.csv"
    echo -n "$1" >> "measure_memory.csv"

    run_tests $1 random-placements-10      "${DATA_DIR}/jplace_10"
    run_tests $1 random-placements-20      "${DATA_DIR}/jplace_20"
    run_tests $1 random-placements-50      "${DATA_DIR}/jplace_50"
    run_tests $1 random-placements-100     "${DATA_DIR}/jplace_100"
    run_tests $1 random-placements-200     "${DATA_DIR}/jplace_200"
    run_tests $1 random-placements-500     "${DATA_DIR}/jplace_500"
    ITERATIONS=3
    run_tests $1 random-placements-1000    "${DATA_DIR}/jplace_1000"
    ITERATIONS=1
    run_tests $1 random-placements-2000    "${DATA_DIR}/jplace_2000"
    run_tests $1 random-placements-5000    "${DATA_DIR}/jplace_5000"
    run_tests $1 random-placements-10000   "${DATA_DIR}/jplace_10000"
    ITERATIONS=5

    echo >> "measure_time.csv"
    echo >> "measure_memory.csv"
}

echo "Start: `date`"
echo
echo "Command                                 Data                                             Size         Min         Max         Avg         Mem        User          Wall "

# Run either all known scripts, or the one provided.
if [ $# -eq 0 ] ; then

    # EDPL
    #run_single_jplace gappa/edpl.sh
    #run_single_jplace guppy/edpl.sh
    #echo

    # KR Distance
    #run_multiple_jplace gappa/kr.sh
    #run_multiple_jplace guppy/kr.sh
    #echo

    # Squash
    #run_multiple_jplace gappa/squash.sh
    #run_multiple_jplace guppy/squash.sh
    #echo

    # Edge PCA
    run_multiple_jplace gappa/edgepca.sh
    run_multiple_jplace guppy/edgepca.sh

else
    #run_tests ${1} ${2}
    echo "Nothing to do"
fi

echo
echo "End: `date`"
