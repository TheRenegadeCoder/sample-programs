module Main where

import System.Environment
import Data.Array (Array, (!))
import qualified Data.Array as Array
import Control.Monad (guard)
import Text.Read

-- Converts string in format "1, 2, 3" to a Maybe array of int
stringToArrayMaybe :: String -> Maybe (Array Int Int)
stringToArrayMaybe str = do
  xs <- readMaybe $ "[" ++ str ++ "]" :: Maybe [Int]
  guard $ (not . null) xs
  return $ Array.listArray (0, length xs - 1) xs

isSorted :: (Ord a) => [a] -> Bool
isSorted []         = True
isSorted [_]        = True
isSorted (x1:x2:xs) = x1 <= x2 && isSorted (x2:xs)

parseArgs :: [String] -> Maybe (Array Int Int, Int)
parseArgs [a, t] = do
  target <- readMaybe t
  array  <- stringToArrayMaybe a
  guard (isSorted (Array.elems array))
  return (array, target)
parseArgs _      = Nothing

binarySearch :: (Ord e) => e -> Array Int e -> Bool
binarySearch x xs = go lo hi
  where
  (lo, hi) = Array.bounds xs
  go l h
    | l > h       = False
    | xs ! m == x = True
    | xs ! m < x  = go (m+1) h
    | otherwise   = go l (m-1)
    where m = (h+l) `quot` 2

main :: IO ()
main = do
  args <- getArgs
  case parseArgs args of
    Nothing ->
      putStrLn "Usage: please provide a list of sorted integers (\"1, 4, 5, 11, 12\") and the integer to find (\"11\")"
    Just (array, target) ->
      let result = binarySearch target array
      in  putStrLn (if result then "true" else "false")

