<?php  
function lcs( $X, $Y, $m, $n ) 
{ 
    $L = array_fill(0, $m + 1,  
         array_fill(0, $n + 1, NULL)); 
    for ($i = 0; $i <= $m; $i++) 
    { 
        for ($j = 0; $j <= $n; $j++) 
        { 
            if ($i == 0 || $j == 0) 
                $L[$i][$j] = 0; 
            else if ($X[$i - 1] == $Y[$j - 1]) 
                $L[$i][$j] = $L[$i - 1][$j - 1] + 1; 
            else
                $L[$i][$j] = max($L[$i - 1][$j],  
                                 $L[$i][$j - 1]); 
        } 
    } 
    $index = $L[$m][$n]; 
    $temp = $index; 
    $lcs = array_fill(0, $index + 1, NULL); 
    $lcs[$index] = ''; 
    $i = $m; 
    $j = $n; 
    while ($i > 0 && $j > 0) 
    { 
       
        if ($X[$i - 1] == $Y[$j - 1]) 
        { 
            // Put current character in result 
            $lcs[$index - 1] = $X[$i - 1]; 
            $i--; 
            $j--;  
            $index--;    // reduce values of i, j and index 
        } 
      
        else if ($L[$i - 1][$j] > $L[$i][$j - 1]) 
            $i--; 
        else
            $j--; 
    } 
    
    echo "LCS of " . $X . " and " . $Y . " is "; 
    for($k = 0; $k < $temp; $k++) 
        echo $lcs[$k]; 
} 
  

$X = "AGGTAB"; 
$Y = "GXTXAYB"; 
$m = strlen($X); 
$n = strlen($Y); 
lcs($X, $Y, $m, $n); 
  

?> 
