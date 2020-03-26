module Main where

import System.Environment

main :: IO ()
main = do
  args <- getArgs
  if null args then
    error "You need to provide us with a string in order to reverse it"
  else
    putStrLn $ reverse $ head args
