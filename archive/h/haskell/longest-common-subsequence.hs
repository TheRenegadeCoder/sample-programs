module Main where

import System.Environment
import System.Exit (exitWith, ExitCode(ExitFailure))
import Data.List (intercalate)

-- Recursively find longest common subsequence
lcs :: Eq a => [a] -> [a] -> [a]
lcs [] bs = []
lcs as [] = []
lcs (a:as) (b:bs)
  | a == b    = (lcs as bs) ++ [a]
  | otherwise = longest (lcs (a:as) bs) (lcs as (b:bs))


-- Returns the longer of two lists
longest :: Foldable t => t a -> t a -> t a
longest l1 l2
  | length l1 > length l2 = l1
  | otherwise             = l2


-- Converts string in format "1, 2, 3" to a list of integers
stringToList :: String -> [Int]
stringToList str = read $ "[" ++ str ++ "]" :: [Int]


listToString :: [Int] -> String
listToString = intercalate ", " . map show


main :: IO ()
main = do
  args <- getArgs
  let l1 = stringToList $ head args :: [Int]
  let l2 = stringToList $ head $ tail args :: [Int]
  if length args /= 2 then do
    putStrLn "Usage: please provide two lists in the format \"1, 2, 3, 4, 5\""
    exitWith $ ExitFailure 1
  else
    putStrLn $ listToString $ reverse $ lcs l1 l2
