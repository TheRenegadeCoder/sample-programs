#!/bin/bash

if [ -z "$1" ]; then
    echo "Usage: please provide a string"
    exit 1
fi

echo ${1^}
