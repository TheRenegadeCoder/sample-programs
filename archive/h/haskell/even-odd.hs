module Main where

import System.Environment

data EvenOdd = Even | Odd deriving (Show)

isEvenOdd :: Int -> EvenOdd
isEvenOdd x
  | x `mod` 2 == 0 = Even
  | otherwise  = Odd

main :: IO ()
main = do
  args <- getArgs
  let x = head args
  if null args then
    error "You need to pass a number through the command line." 
  else
    putStrLn $ show $ isEvenOdd $ (read x :: Int)
