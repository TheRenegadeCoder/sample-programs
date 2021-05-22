<?php
/**
 * by: Mohd Samgan Khan
 * its assumed that the file is running through command line
 * inputs are read from the same.
 *
 * palindromes are those words which are same from from and back.
 * like: mam, Civic, Anna etc.
 *
 * Program logic: logic lies in the concept itself. we will match if the reverse of the word is
 * same as the word. If true then it's a palindrome else it's not.
 * But, there is a minor catch "Care sensitivity". So, we will make sure that both the comparision params
 * should be in same case.
 */

$argv[1] = strtolower($argv[1]);
if (strrev($argv[1]) === $argv[1]) {
    echo 'Word is a palindrome';
} else {
    echo 'Sorry love, word is not a palindrome';
}
