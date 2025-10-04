#!/bin/bash

read_file () {
  cat output.txt
}

write_file () {
    echo -e "$1" > output.txt
}

write_file "File text line 1\nFile text line 2\nFile text line 3"
read_file
