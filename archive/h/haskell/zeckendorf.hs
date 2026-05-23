module Main where

import Data.Maybe (listToMaybe)
import Data.Function ((&))
import Data.List (intercalate)
import Control.Monad (guard)
import Text.Read (readMaybe)
import System.Environment (getArgs)

listToString :: [Int] -> String
listToString = intercalate ", " . map show

fib :: [Int]
fib = 1 : 1 : zipWith (+) fib (drop 1 fib)

zeckendorf :: Int -> [Int]
zeckendorf n =
  takeWhile (<= n) fib
  & foldr (\m (n, l) -> if m <= n then (n-m, m:l) else (n, l)) (n, [])
  & snd
  & reverse

parseArgs :: [String] -> Maybe Int
parseArgs args = do
  n  <- listToMaybe args
  n' <- readMaybe n
  guard (n' >= 0)
  return n'

main :: IO ()
main = do
  args <- getArgs
  case parseArgs args of
    Nothing -> putStrLn "Usage: please input a non-negative integer"
    Just n  -> putStrLn $ listToString (zeckendorf n)

