#!/bin/bash
if [ "$#" -lt 2 ]
then
    echo "Usage: $0 <language> <filename> [<times>]"
    echo "where:"
    echo "- <language> is the language directory"
    echo "- <filename> is the base filename of the sample"
    echo "- <times> is the number of times to run 'glotter run'. Default: 100"
    exit 1
fi

LANGUAGE="$1"
FILENAME="$2"
TIMES="${3:-10}"

$(poetry env activate)

OUTPUT=iterations.txt
rm -rf $OUTPUT
for ((i=1; i <= "${TIMES}"; i++))
do
    echo "*** $i ***" | tee -a "${OUTPUT}"
    if ! glotter test -s sleep-sort.asm --parallel
    then
        echo "ERROR" | tee -a "${OUTPUT}"
        exit 1
    fi
done
echo "PASS" | tee -a "${OUTPUT}"
