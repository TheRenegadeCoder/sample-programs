#!/usr/bin/env bash

[[ $# -eq 0 ]] && echo "Usage: please provide a string to encrypt" && exit 0

echo "$@" | tr '[A-Za-z]' '[N-ZA-Mn-za-m]'

exit 0
