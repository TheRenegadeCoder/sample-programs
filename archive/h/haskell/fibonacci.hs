module Main where

import System.Environment

fibonacciSequence :: Int -> [Int]
fibonacciSequence 0            = []
fibonacciSequence elementCount = go 0 [0,1]
  where go iteration sequence
          | iteration < elementCount = go (iteration + 1) $ sequence ++ [ ( sum $ take 2 $ reverse sequence ) ]
          | otherwise                = sequence


-- Prints out the first N numbers from the fibonacci sequence
-- where N equals to the first command line argument.
main :: IO ()
main = do
  args <- getArgs
  let n = head args
  if null args then
    error "You need to pass the number of the fibonacci elements to calculate through the command line\n"
  else
    let message  = "\nThe first " ++ n ++ " fibonacci numbers are: \n"
        sequence = fibonacciSequence $ read n
    in putStrLn $ message ++ show sequence
