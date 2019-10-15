<?php

/**
 * Write test strings to the specified file.
 * @param string $file_name File name to use.
 * @return boolean TRUE on success, FALSE otherwise.
 */
function write_file($file_name) {
    $file = @fopen($file_name, "w");
    if ($file === FALSE) {
        echo "Cannot open file \"", $file_name, "\" for writing.\n";
        return FALSE;
    }

    fwrite($file, "Hello World.\n");
    fwrite($file, "Testing one...\n");
    fwrite($file, "two...\n");
    fwrite($file, "three!\n");

    fflush($file);
    fclose($file);
    return TRUE;
}

/**
 * Read file content line by line and output to console.
 * @param string $file_name File to read.
 */
function read_file($file_name) {
    $file = @fopen($file_name, "r");
    if ($file === FALSE) {
        echo "Cannot open file \"", $file_name, "\" for reading.\n";
        return;
    }

    while (!feof($file)) {
        echo fgets($file);
    }

    fclose($file);
}

// Write, read, delete file
$file_name = "output.txt";
if (write_file($file_name)) {
    read_file($file_name);
}

?>
