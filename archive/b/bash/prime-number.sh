#!/bin/bash

ERROR="Usage: please input a non-negative integer"

# based on https://stackoverflow.com/questions/45392068/check-if-a-number-is-a-prime-in-bash
function is_prime(){
    if [[ $1 -eq 2 ]] || [[ $1 -eq 3 ]]; then
        return 1  # prime
    fi
    if [[ $(($1 % 2)) -eq 0 ]] || [[ $(($1 % 3)) -eq 0 ]] || [[ $1 -eq 1 ]]; then
        return 0  # not a prime
    fi
    i=5; w=2
    while [[ $((i * i)) -le $1 ]]; do
        if [[ $(($1 % i)) -eq 0 ]]; then
            return 0  # not a prime
        fi
        i=$((i + w))
        w=$((6 - w))
    done
    return 1  # prime
}

# validate input number
if [[ -z "${1}" ]]
then
	echo "${ERROR}"
	exit 1
fi

if ! [[ "${1}" =~ ^[0-9]+$ ]]
then
  echo "${ERROR}"
  exit 1
fi

# sample usage
is_prime ${1}
if [[ $? -eq 0 ]];
then
  echo "composite"
else
  echo "prime"
fi

exit 0
