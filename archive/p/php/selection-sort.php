<?php

$arr = array(1,10,2,4,3,7,6,9,0,8,5);

$noElements = count($arr);

for($count=0; $count <= $noElements; $count++)
{
    for($incremented=$count+1; $incremented<=$noElements; $incremented++)
    {
        if($arr[$count] > $arr[$incremented] )
        {
            $curIncrement = $arr[$incremented];
            $arr[$incremented] = $arr[$count];
            $arr[$count] = $curIncrement;
        }
    }

    echo $arr[$count].PHP_EOL;
}