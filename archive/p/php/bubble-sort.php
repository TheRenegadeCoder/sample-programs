<?php

$numbers = array_map('intval', explode(',', $argv[1]));
$array_size = count($numbers);

if ($array_size <= 1)
{
    exit('Usage: please provide a list of at least two integers to sort in the format "1, 2, 3, 4, 5"');
}


for ( $i = 0; $i < $array_size; $i++ )
{
   for ($j = 0; $j < $array_size; $j++ )
   {
      if ($numbers[$i] < $numbers[$j])
      {
         $temp = $numbers[$i];
         $numbers[$i] = $numbers[$j];
         $numbers[$j] = $temp;
      }
   }
}

echo implode(', ', $numbers);

?>