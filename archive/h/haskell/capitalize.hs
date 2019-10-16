module Main where 
import Data.Char

capitalize :: String -> String
capitalize (head:tail) = toUpper head : map toLower tail
capitalize [] = []

main = do  
    putStrLn "Input string of choice to capitalize first letter"
    inputStr <- getLine  
    if null inputStr
        then return ()
        else do putStrLn $ capitalize inputStr


