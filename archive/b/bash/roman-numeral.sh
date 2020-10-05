#!/bin/bash
set -eu -o pipefail

roman_numerals=$(echo $1 | tr a-z A-Z)

# Checking the validity
[[ "${roman_numerals//[IVXLCDM]/}" == "" ]] || \
    { echo Roman numerals ${roman_numerals} contains invalid characters ; \
    exit 1 ;}

# Replace all tokens to eventually have all I's
# Remove new lines and count the characters.
number=$(
    echo ${roman_numerals} |
    sed 's/CM/DCD/g' |
    sed 's/M/DD/g' |
    sed 's/CD/CCCC/g' |
    sed 's/D/CCCCC/g' |
    sed 's/XC/LXL/g' |
    sed 's/C/LL/g' |
    sed 's/XL/XXXX/g' |
    sed 's/L/XXXXX/g' |
    sed 's/IX/VIV/g' |
    sed 's/X/VV/g' |
    sed 's/IV/IIII/g' |
    sed 's/V/IIIII/g' |
    tr -d '\n' |
    wc -m
)

echo ${roman_numerals} is ${number}
