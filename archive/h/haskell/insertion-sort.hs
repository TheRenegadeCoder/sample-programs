module Main where

import System.Environment
import Text.Read


insertion :: Ord a => [a] -> [a]
insertion = go []
  where go sorted []     = sorted
        go sorted (x:xs) = go (insert x sorted) xs


insert :: Ord a => a -> [a] -> [a]
insert a [] = [a]
insert a (x:xs)
  | a > x     = x:insert a xs
  | otherwise = a:x:xs


headMaybe :: [a] -> Maybe a
headMaybe []     = Nothing
headMaybe (x:xs) = Just x

-- Converts string in format "1, 2, 3" to a Maybe list of int
stringToListMaybe :: String -> Maybe [Int]
stringToListMaybe str = readMaybe $ "[" ++ str ++ "]" :: Maybe [Int]

-- Ensure that a list contains at least two elements
verifyListLength :: Ord a => [a] -> Maybe [a]
verifyListLength []     = Nothing
verifyListLength [x]    = Nothing
verifyListLength (x:xs) = Just (x:xs)


main :: IO ()
main = do
  args <- getArgs
  let xs = headMaybe args >>= stringToListMaybe >>= verifyListLength
  case xs of
    Nothing -> putStrLn "Usage: please provide a list of at least two integers to sort in the format \"1, 2, 3, 4, 5\""
    Just xs  -> putStrLn $ show $ insertion xs

