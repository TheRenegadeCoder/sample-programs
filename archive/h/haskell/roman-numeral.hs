module Main where

import System.Environment

asDec :: Char -> Int
asDec 'I' = 1
asDec 'V' = 5
asDec 'X' = 10
asDec 'L' = 50
asDec 'C' = 100
asDec 'D' = 500
asDec 'M' = 1000
asDec _   = -1

romanToDecimal :: String -> Int
romanToDecimal roman = _romanToDecimal roman 0

_romanToDecimal :: String -> Int -> Int
_romanToDecimal [a] totals  = totals + (asDec a)
_romanToDecimal (a1:a2:as) totals
  | (asDec a1) < (asDec a2) = _romanToDecimal (a2:as) (totals - (asDec a1))
  | otherwise               = _romanToDecimal (a2:as) (totals + (asDec a1))


main :: IO ()
main = do
  args <- getArgs
  let roman = head args
  if null args then
    error "You need to pass a roman numeral to through the command line." 
  else
    putStrLn $ show $ romanToDecimal roman
