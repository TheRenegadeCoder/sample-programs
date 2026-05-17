module Main where 

import Text.Read (readMaybe)
import Data.Maybe (listToMaybe)
import System.Environment

reverseInt :: Int -> Int
reverseInt n = go n 0
  where go 0 acc = acc
        go n acc = go (n `div` 10) (acc * 10 + n `mod` 10)

main :: IO ()
main = do  
    args <- getArgs
    case listToMaybe args >>= readMaybe of
      Just n  ->
        if n >= 0
        then putStrLn (if reverseInt n == n then "true" else "false") 
        else putStrLn "Usage: please input a non-negative integer"
      Nothing -> putStrLn "Usage: please input a non-negative integer"
