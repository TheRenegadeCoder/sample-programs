<?php
/**
 * by: Ricky Putra
 * its assumed that the file is running through command line
 * inputs are read from the same.
 */

  $input = $argv[1];
  $length = strlen($input);
  for ($i=($length-1) ; $i >= 0 ; $i--) {  
    echo $string[$i];  
  }

?>