#!/bin/bash

for phrase in "$@"
do
    if [[ $phrase =~ [0-9] ]]; then
        echo "Arguments must be strings"
        exit 1
    fi
    echo ${phrase^}
done