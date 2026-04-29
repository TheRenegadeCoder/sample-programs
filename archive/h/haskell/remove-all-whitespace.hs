module Main where

import Data.Char (isSpace)
import System.Environment

headMaybe :: [a] -> Maybe a
headMaybe []     = Nothing
headMaybe (x:xs) = Just x

verifyStringNotEmpty :: String -> Maybe String
verifyStringNotEmpty "" = Nothing
verifyStringNotEmpty xs = Just xs

main :: IO ()
main = do
  args <- getArgs
  let inputStr = headMaybe args >>= verifyStringNotEmpty
  case inputStr of
    Just str -> putStrLn $ filter (not . isSpace) str
    Nothing  -> putStrLn "Usage: please provide a string"
