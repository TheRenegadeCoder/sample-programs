<?php
  $input = $argv[1];
  $length = strlen($input);
  for ($i=($length-1) ; $i >= 0 ; $i--) {
    echo $input[$i];
  }

?>
