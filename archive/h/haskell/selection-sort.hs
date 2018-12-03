module Main where

import System.Environment
import Text.Read
import Data.List (delete)


selection :: Ord a => [a] -> [a]
selection xs = selection' [] xs
  where selection' :: Ord a => [a] -> [a] -> [a]
        selection' ss [] = ss
        selection' ss us = selection' (ss ++ [x]) (delete x us)
          where x = minimum us


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
    Just xs  -> putStrLn $ show $ selection xs

