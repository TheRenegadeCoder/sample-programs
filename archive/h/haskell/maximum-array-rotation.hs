module Main where

import System.Environment
import Text.Read
import Data.List (tails)

headMaybe :: [a] -> Maybe a
headMaybe []     = Nothing
headMaybe (x:xs) = Just x

stringToListMaybe :: String -> Maybe [Int]
stringToListMaybe str = readMaybe $ "[" ++ str ++ "]" :: Maybe [Int]

verifyListNotEmpty :: [a] -> Maybe [a]
verifyListNotEmpty [] = Nothing
verifyListNotEmpty xs = Just xs

-- get all rotated versions of the list xs
rotations :: [a] -> [[a]]
rotations xs =
  let n = length xs
  in take n $ map (take n) $ tails (cycle xs)

main :: IO ()
main = do
  args <- getArgs
  let xs = headMaybe args >>= stringToListMaybe >>= verifyListNotEmpty
  case xs of
    Just xs -> print $ maximum $ map (sum . zipWith (*) [0..]) $ rotations xs
    Nothing -> putStrLn "Usage: please provide a list of integers (e.g. \"8, 3, 1, 2\")"
  
