: baklava
  ( for counter = -10 to 10 )
  11 -10 do
    i                       \ put outermost loop index on the stack
    abs                     \ num-spaces = abs(counter)
    dup spaces              \ output num-spaces " "
    -2 * 21 +               \ num-stars = 21 - 2 * num-spaces
    0 do [char] * emit loop \ for inner-counter = 0 to num-stars - 1, output "*"
                            \ Source: https://rosettacode.org/wiki/Loops/For#Forth
    cr
    loop ;

baklava
bye
