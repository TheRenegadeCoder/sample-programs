module Main where 

import Data.Char
import System.Environment

capitalize :: String -> String
capitalize (head:tail) = toUpper head : tail
capitalize [] = []

main = do  
    args <- getArgs
    case args of
      [inputStr] -> case inputStr of
        [] -> putStrLn "Usage: please provide a string"
        _  -> putStrLn $ capitalize inputStr
      _          -> putStrLn "Usage: please provide a string"
