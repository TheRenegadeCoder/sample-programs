module Main where

import System.Environment
import Data.Function ((&))

usage :: String
usage = "Usage: please provide a string"

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
    Just str -> str & words & map length & maximum & print
    Nothing  -> putStrLn "Usage: please provide a string"
