<?php
$values= array(1,4,10,3,30,14,5);
$size = count($values);

for($i=0;$i<=$size;$i++)
  {
	for($j=$i+1;$j<=$size;$j++)
       {
        if($values[$j] < $values[$i])
        {
            $min = $values[$j];
            $values[$j] = $values[$i];
            $values[$i] = $min;
        }    
       }
    print $values[$i]."\n";
      
  }
   
