module Main where

import Data.Char
import System.Environment
import System.Exit (exitWith, ExitCode(ExitFailure))

rot13 :: String -> String
rot13 = map encryptChar

encryptChar :: Char -> Char
encryptChar c
  | ord c >= 65 && ord c <= 90  = toChar 65 $ addDigits $ toNum 65 c
  | ord c >= 97 && ord c <= 122 = toChar 97 $ addDigits $ toNum 97 c
  | otherwise = c
    where toNum base c = (ord c) - base
          toChar base n = chr $ n + base
          addDigits n = (n + 13) `mod` 26



main :: IO ()
main = do
  args <- getArgs
  if null args || (head args) == "" then do
    putStrLn "Usage: please provide a string to encrypt"
    exitWith $ ExitFailure 1
  else
    putStrLn $ rot13 $ head args
