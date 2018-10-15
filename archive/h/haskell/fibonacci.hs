module Main where

fibonacciSequence :: Int -> [Int]
fibonacciSequence 0            = []
fibonacciSequence elementCount = go 0 [0,1]
  where go iteration sequence
          | iteration < elementCount = go (iteration + 1) $ sequence ++ [ ( sum $ take 2 $ reverse sequence ) ]
          | otherwise                = sequence


-- Prints out the first 10 numbers from the fibonacci sequence.
main :: IO ()
main = do
  putStrLn "The first 10 fibonacci numbers are:"
  putStrLn $ show $ fibonacciSequence 10
