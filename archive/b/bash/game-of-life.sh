#!/bin/bash

# Build grid.
# $1 width
# $2 percent spawn rate 0 to 100
build_grid() {
    let area=$1*$1
    __retval=''
    for (( i=0; i < $area; i++ )); do
        let rnd=$RANDOM%100+1
        if [ $rnd -lt $2 ]; then
            __retval+="1"
        else 
            __retval+="0"
        fi
    done
}

# Check if there's a cell at the specified location
# $1 x
# $2 y
# $3 width
# $4 grid
contains_cell() {
    local x=$1
    local y=$2

    while [ $x -lt 0 ]; do
        let x=$x+$3
    done
    while [ $y -lt 0 ]; do
        let y=$y+$3
    done
    while [ $x -ge $3 ]; do
        let x=$x-$3
    done
    while [ $y -ge $3 ]; do
        let y=$y-$3
    done

    let i=$x+$y*$3
    __retval=${4:$i:1}
}

# Count the number of neighbors on a specified cell
# $1 x
# $2 y
# $3 width
# $4 grid
neighbor_count() {
    local count=0

    let nx=$1-1
    let ny=$2-1
    contains_cell $nx $ny $3 $4
    if [ $__retval -eq 1 ]; then
        let count=$count+1
    fi

    let nx=$1
    let ny=$2-1
    contains_cell $nx $ny $3 $4
    if [ $__retval -eq 1 ]; then
        let count=$count+1
    fi

    let nx=$1+1
    let ny=$2-1
    contains_cell $nx $ny $3 $4
    if [ $__retval -eq 1 ]; then
        let count=$count+1
    fi

    let nx=$1-1
    let ny=$2
    contains_cell $nx $ny $3 $4
    if [ $__retval -eq 1 ]; then
        let count=$count+1
    fi

    let nx=$1+1
    let ny=$2
    contains_cell $nx $ny $3 $4
    if [ $__retval -eq 1 ]; then
        let count=$count+1
    fi

    let nx=$1-1
    let ny=$2+1
    contains_cell $nx $ny $3 $4
    if [ $__retval -eq 1 ]; then
        let count=$count+1
    fi

    let nx=$1
    let ny=$2+1
    contains_cell $nx $ny $3 $4
    if [ $__retval -eq 1 ]; then
        let count=$count+1
    fi

    let nx=$1+1
    let ny=$2+1
    contains_cell $nx $ny $3 $4
    if [ $__retval -eq 1 ]; then
        let count=$count+1
    fi

    __retval=$count
}

# Generate the next generation grid
# $1 the width
# $2 the current grid
next_generation() {
    __cell_count=0
    local next_grid=''

    for (( y=0; y < $1; y++ )); do
        for (( x=0; x < $1; x++ )); do
            neighbor_count $x $y $1 $2
            local neighbors=$__retval

            # If alive and 2 or 3 neighbors, keep alive
            contains_cell $x $y $1 $2
            if [ $__retval -eq 1 ]; then
                if [[ $neighbors -eq 2 || $neighbors -eq 3 ]]; then
                    next_grid+="1"
                    let __cell_count++
                else
                    next_grid+="0"
                fi

            # If dead and exactly 3 neighbors, birth it.
            else
                if [ $neighbors == 3 ]; then
                    next_grid+="1"
                    let __cell_count++
                else
                    next_grid+="0"
                fi
            fi
        done
    done

    __retval=$next_grid
}

# Repeat a string.
# $1 the string to repeat
# $2 the times to repeat the string
repeat_string() {
    for (( i=0; i < $2; i++ )); do
        echo -n $1
    done
}

# Print the grid.
# $1 the width of the grid
# $2 the grid
print_grid() {
    let area=$1*$1

    # top border
    echo -n '+'
    repeat_string '--' $1
    echo '+'

    echo -n "|"
    for (( i=0; i < $area; i++ )); do
        let nl=$i%$1==0
        if [[ $nl -eq 1 && $i -ne 0 ]]; then
            echo "|"
            echo -n "|"
        fi

        if [ ${2:$i:1} -eq 1 ]; then
            echo -n ' O'
        else
            echo -n ' .'
        fi
    done
    echo "|"

    # bottom border
    echo -n '+'
    repeat_string '--' $1
    echo '+'
}

# defaults
WIDTH=10
SPAWN=25
FRAMES=20

# arg check
if [ "x$1" == "x" ]; then
    echo "Usage: -f|--total-frames FRAMES [-r|--frame-rate RATE] [-w|--width WIDTH] [-s|--spawn-rate RATE]"
    exit 1
fi

# parse arguments
while (( "$#" )); do
    case "$1" in
        -w|--width)
            WIDTH=$2
            shift 2
        ;;
        -r|--frame-rate)
            # ignore frame rate, already too slow
            shift 2
        ;;
        -f|--total-frames)
            FRAMES=$2
            shift 2
        ;;
        -s|--spawn-rate)
            SPAWN=$(echo "scale=2;$2*100" | bc)
            SPAWN=${SPAWN/.*/}
            if [[ $SPAWN -gt 100 || $SPAWN -lt 0 ]]; then
                echo "Spawn rate must be between 0.0 and 1.0"
                exit 1
            fi
            shift 2
        ;;
        -*|--*=)
            echo "Error: Unsupported flag $1" >&2
            exit 1
    esac
done

# output values
echo "Width: $WIDTH"
echo "Total Frames: $FRAMES"
echo "Spawn Rate: $SPAWN"
echo

# build first grid
build_grid $WIDTH $SPAWN
grid=$__retval
print_grid $WIDTH $grid

# build next generations
for (( f=1; f < $FRAMES; f++ )); do
    next_generation $WIDTH $grid
    grid=$__retval
    print_grid $WIDTH $grid

    # no more live cells, break
    if [ $__cell_count -eq 0 ]; then
        break
    fi
done

