<?php

 
    for($i=0;$i<=10;$i++)
        echo str_repeat(' ', 10 - $i).str_repeat('*', $i * 2 + 1)."\n";
    
    for($i=10;$i>=0;$i--)
        echo str_repeat(' ', 10 - $i).str_repeat('*', $i * 2 + 1)."\n";

    echo "\n";

?>