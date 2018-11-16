module Main where

import System.Environment
import Text.Read

fibonacciSequence :: Int -> [Int]
fibonacciSequence 0            = []
fibonacciSequence elementCount = go 0 [0,1]
  where go iteration sequence
          | iteration < elementCount = go (iteration + 1) $ sequence ++ [ ( sum $ take 2 $ reverse sequence ) ]
          | otherwise                = sequence


headMaybe :: [a] -> Maybe a
headMaybe []     = Nothing
headMaybe (x:xs) = Just x


-- Takes a list of values and returns a list of strings in the format "ONE_BASED_INDEX: VALUE"
printWithIndex :: (Show a) => [a] -> [[Char]]
printWithIndex = zipWith (\i x -> (show i) ++ ": " ++ (show x)) [1..]


-- Prints out the first N numbers from the fibonacci sequence
-- where N equals to the first command line argument.
main :: IO ()
main = do
  args <- getArgs
  let n = headMaybe args
  case n >>= readMaybe of
    Nothing -> putStrLn "Usage: please input the number of fibonacci elements to calculate as a positive integer"
    Just n  -> mapM_ (putStrLn) $ (printWithIndex . fibonacciSequence) n
