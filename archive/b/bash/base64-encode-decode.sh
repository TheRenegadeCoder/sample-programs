#!/bin/bash

# References:
# - Convert character to ASCII code, and ASCII code to character:
#   https://unix.stackexchange.com/questions/92447/bash-script-to-get-ascii-values-for-alphabet

BASE64_CHARS="ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"

function usage() {
    echo "Usage: please provide a mode and a string to encode/decode"
    exit 1
}

# Base64 encode string
#
# Input:
# - $1 = string to encode
# Output: Base64 encoded string
function base64_encode() {
    local result=""
    local len=${#1}
    for ((n=0; n<${len}; n+=3))
    do
        # Convert 3-character chunk into 24-bit value
        local n1=$(ord "${1:${n}:1}")
        local n2=$(ord "${1:$((${n}+1)):1}")
        local n3=$(ord "${1:$((${n}+2)):1}")
        local u=$(( (${n1}<<16)|(${n2}<<8)|${n3} ))

        # Convert 24-bit value to 4 Base64 characters
        c1="$(base64_encode_char ${u} 18 ${n} 0 ${len})"
        c2="$(base64_encode_char ${u} 12 ${n} 0 ${len})"
        c3="$(base64_encode_char ${u} 6 ${n} 1 ${len})"
        c4="$(base64_encode_char ${u} 0 ${n} 2 ${len})"
        result="${result}${c1}${c2}${c3}${c4}"
    done

    echo "${result}"
}

# Base64 encode character
#
# Inputs:
# - $1 = 24-bit value
# - $2 = number of shifts
# - $3 = string index
# - $4 = string index offset (0 - 2)
# - $5 = length of string
# Output: Base64 encoded character
function base64_encode_char() {
    local u=${1}
    local shifts=${2}
    local index=$((${3}+${4}))
    local len=${5}
    local result="="
    if [[ ${index} -lt ${len} ]]
    then
        result="${BASE64_CHARS:$(( (${u}>>${shifts})&0x3f )):1}"
    fi

    echo "${result}"
}

# Base64 decode string
#
# Input:
# - $1 = Base64 string to decode
# Output: Base64 decoded string
# Exits if invalid Base64 string is invalid
function base64_decode() {
    # Error if string not a multiple of 4
    local s="${1}"
    local len=${#s}
    if [[ $((${len}%4)) -ne 0 ]]
    then
        usage
    fi

    # Trim trailing pad characters
    local pads=0
    while [[ ${len} -gt 0 ]] && [ "${s:$((${len}-1)):1}" = "=" ]
    do
        len=$((${len}-1))
        pads=$((${pads}+1))
    done
    s="${s:0:${len}}"

    # Error if too many pad characters
    if [[ ${pads} -gt 2 ]]
    then
        usage
    fi

    local result=""
    for ((n=0; n<${len}; n+=4))
    do
        # Convert 4-character chunk into indices
        local n1=$(base64_decode_index "${s:${n}:1}")
        local n2=$(base64_decode_index "${s:$((${n}+1)):1}")
        local n3=$(base64_decode_index "${s:$((${n}+2)):1}")
        local n4=$(base64_decode_index "${s:$((${n}+3)):1}")

        # Exit if any invalid Base64 characters
        if [[ ${n1} -lt 0 ]] || [[ ${n2} -lt 0 ]] || [[ ${n3} -lt 0 ]] || [[ ${n4} -lt 0 ]]
        then
            usage
        fi

        # Convert indices to 24-bit value
        local u=$(( (${n1}<<18)|(${n2}<<12)|(${n3}<<6)|${n4} ))

        # Convert 24-bit value to Base64 decoded characters
        c1="$(base64_decode_char ${u} 16 ${n} 0 ${len})"
        c2="$(base64_decode_char ${u} 8 ${n} 2 ${len})"
        c3="$(base64_decode_char ${u} 0 ${n} 3 ${len})"
        result="${result}${c1}${c2}${c3}"
    done

    echo "${result}"
}

# Convert character to Base64 decode index
#
# Input:
# - $1 = character
# Output:
# - Base64 decode index if character is a valid Base64 character,
#   0 if empty string, -1 otherwise
function base64_decode_index() {
    result=$(ord "${1}")
    case "${1}" in
        "")
            result=0
            ;;
        [A-Z])
            # result = ord(char) - ord("A")
            result=$((${result}-65))
            ;;
        [a-z])
            # result = ord(char) - ord("a") + 26
            result=$((${result}-97+26))
            ;;
        [0-9])
            # result = ord(char) - ord("0") + 52
            result=$((${result}-48+52))
            ;;
        +)
            result=62
            ;;
        /)
            result=63
            ;;
        *)
            result=-1
            ;;
    esac

    echo ${result}
}

# Base64 decode character
#
# Inputs:
# - $1 = 24-bit value
# - $2 = number of shifts
# - $3 = string index
# - $4 = string index offset (0 - 3)
# - $5 = length of string
# Output: Base64 decoded character
function base64_decode_char() {
    local u=${1}
    local shifts=${2}
    local index=$((${3}+${4}))
    local len=${5}
    local result=""
    if [[ ${index} -lt ${len} ]]
    then
        result="$(chr $(( (${u}>>${shifts})&0xff )) )"
    fi

    echo "${result}"
}

# Convert ASCII code to character
#
# Input:
# - $1 = ASCII code
# Output: character
function chr() {
    printf "\\$(printf '%03o' "${1}")"
}

# Convert character to ASCII code
#
# Input:
# - $1 = character
# Output:
# - ASCII code if character is not empty, 0 otherwise
function ord() {
    LC_CTYPE=C printf '%d' "'${1}"
}

# Error if string
if [ -z "$2" ]
then
    usage
fi

# Base64 encode/decode string if valid mode, error otherwise
case "$1" in
    encode)
        base64_encode "$2"
        ;;

    decode)
        base64_decode "$2"
        ;;

    *)
        usage
        ;;
esac
