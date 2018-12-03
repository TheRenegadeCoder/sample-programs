module Main where

import System.Environment
import Text.Read


bubble :: Ord a => [a] -> [a]
bubble xs = foldl (\acc _ -> pass acc) xs xs
  where pass [x] = [x]
        pass (x1:x2:xs)
          | x1 > x2   = x2:(pass (x1:xs))
          | otherwise = x1:(pass (x2:xs))


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
    Just xs  -> putStrLn $ show $ bubble xs

