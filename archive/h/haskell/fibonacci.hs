module Main where

fibonacciSequence :: Int -> [Int]
fibonacciSequence 0            = []
fibonacciSequence elementCount = go 0 [0,1]
  where go iteration sequence
          | iteration < elementCount = go (iteration + 1) $ sequence ++ [ ( sum $ take 2 $ reverse sequence ) ]
          | otherwise                = sequence


-- Gets the first N elements of the fibonacciSequence
main n = fibonacciSequence n
