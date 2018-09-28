<?php

for ($i = 1; $i < 101; $i++)
{
  $output = "";

  if ($i % 3 == 0)
  {
    $output .= "Fizz";
  }

  if ($i % 5 == 0)
  {
    $output .= "Buzz";
  }

  if (!$output)
  {
    $output = $i;
  }

  echo $output . "\n";
}
