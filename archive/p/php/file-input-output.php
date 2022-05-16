<?php

function write_file($file_name)
{
    $file = @fopen($file_name, "w");
    if ($file === false) {
        echo "Cannot open file \"", $file_name, "\" for writing.\n";
        return false;
    }

    fwrite($file, "Hello World.\n");
    fwrite($file, "Testing one...\n");
    fwrite($file, "two...\n");
    fwrite($file, "three!\n");

    fflush($file);
    fclose($file);
    return true;
}

function read_file($file_name)
{
    $file = @fopen($file_name, "r");
    if ($file === false) {
        echo "Cannot open file \"", $file_name, "\" for reading.\n";
        return;
    }

    while (!feof($file)) {
        echo fgets($file);
    }

    fclose($file);
}

$file_name = "output.txt";
if (write_file($file_name)) {
    read_file($file_name);
}
