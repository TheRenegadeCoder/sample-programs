module Main where

import Text.Read
import System.Environment

josephus :: Int -> Int -> Int
josephus 1 _ = 1
josephus n k = (josephus (n-1) k + k - 1) `mod` n + 1

parseArgs :: [String] -> Maybe (Int, Int)
parseArgs [n, k] = do
  n' <- readMaybe n
  k' <- readMaybe k
  return (n', k')
parseArgs _ = Nothing

main :: IO ()
main = do
  args <- getArgs
  case parseArgs args of
    Just (n, k) -> print (josephus n k)
    Nothing     -> putStrLn "Usage: please input the total number of people and number of people to skip."
