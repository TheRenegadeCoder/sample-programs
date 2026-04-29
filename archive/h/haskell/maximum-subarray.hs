module Main where

import System.Environment
import Text.Read

headMaybe :: [a] -> Maybe a
headMaybe []     = Nothing
headMaybe (x:xs) = Just x

-- Converts string in format "1, 2, 3" to a Maybe list of int
stringToListMaybe :: String -> Maybe [Int]
stringToListMaybe str = readMaybe $ "[" ++ str ++ "]" :: Maybe [Int]

verifyListNotEmpty :: [a] -> Maybe [a]
verifyListNotEmpty [] = Nothing
verifyListNotEmpty xs = Just xs

main :: IO ()
main = do
  args <- getArgs
  let xs = headMaybe args >>= stringToListMaybe >>= verifyListNotEmpty
  case xs of
    Just xs -> print $ maximum $ scanr1 (\x acc -> if acc < 0 then x else x + acc)  xs
    Nothing -> putStrLn "Usage: Please provide a list of integers in the format: \"1, 2, 3, 4, 5\""
