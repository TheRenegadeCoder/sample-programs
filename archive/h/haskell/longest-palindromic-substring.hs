module Main where

import System.Environment
import Data.List (maximumBy, tails, inits)
import Data.Maybe (listToMaybe)
import Data.Function ((&))
import Data.Ord (comparing)

substrings :: [a] -> [[a]]
substrings = concatMap tails . inits

longestPalindromicSubstring :: String -> Maybe String
longestPalindromicSubstring str =
  case palindromes of
    [] -> Nothing
    _  -> Just $ maximumBy (comparing length) palindromes
  where palindromes = substrings str & filter (\s -> length s > 1 && reverse s == s)

main :: IO ()
main = do
  args <- getArgs
  case listToMaybe args >>= longestPalindromicSubstring of
    Nothing  -> putStrLn "Usage: please provide a string that contains at least one palindrome"
    Just res -> putStrLn res
