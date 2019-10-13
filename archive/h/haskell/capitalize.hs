module Main where 
import Data.Char


capitalize :: String -> String
capitalize (head:tail) = toUpper head : map toLower tail
capitalize [] = []


main = do  
    -- TODO: error handling when user inputs nothing
    putStrLn "Input string to capitalize first letter"
    firstName <- getLine  
    print (capitalize firstName)
