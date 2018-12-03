module Main where

import System.Environment
import Text.Read


mergeSort :: Ord a => [a] -> [a]
mergeSort xs = head $ mergeSort' $ fmap (:[]) xs
  where mergeSort' :: Ord a => [[a]] -> [[a]]
        mergeSort' [] = []
        mergeSort' [x] = [x]
        mergeSort' (x1:x2:xs) = mergeSort' $ merge x1 x2:mergeSort' xs

merge :: Ord a => [a] -> [a] -> [a]
merge x [] = x
merge [] y = y
merge (x:xs) (y:ys)
  | x < y     = x:merge xs     (y:ys)
  | otherwise = y:merge (x:xs) ys


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
    Just xs  -> putStrLn $ show $ mergeSort xs

