module Main where

import System.Environment
import Text.Read

-- Converts string in format "1, 2, 3" to a Maybe list of int
stringToListMaybe :: String -> Maybe [Int]
stringToListMaybe str = readMaybe $ "[" ++ str ++ "]" :: Maybe [Int]

-- Ensure that a list is not empty
verifyListLength :: [a] -> Maybe [a]
verifyListLength [] = Nothing
verifyListLength xs = Just xs

usage :: String
usage = "Usage: please provide a list of integers (\"1, 4, 5, 11, 12\") and the integer to find (\"11\")"

main :: IO ()
main = do
  args <- getArgs
  case args of
    [xs, key] -> do
      let xs'  = stringToListMaybe xs >>= verifyListLength
      let key' = readMaybe key
      case elem <$> key' <*> xs' of
        Just res -> putStrLn (if res then "true" else "false")
        Nothing  -> putStrLn usage
    _         -> putStrLn usage
