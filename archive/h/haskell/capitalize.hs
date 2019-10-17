module Main where 

import Data.Char
import System.Environment

capitalize :: String -> String
capitalize (head:tail) = toUpper head : tail
capitalize [] = []

main = do  
    [inputStr] <- getArgs
    if null inputStr then
        error "Input string of choice to capitalize first letter"
    else
        putStrLn $ capitalize inputStr

