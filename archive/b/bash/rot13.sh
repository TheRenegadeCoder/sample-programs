#!/bin/bash
if [ -z "$1" ]
then
    echo "Usage: please provide a string to encrypt"
    exit 1
else
    echo "$1" | tr 'a-zA-Z' 'n-za-mN-ZA-M'
fi
