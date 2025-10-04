module Main where

import System.Environment

main :: IO ()
main = do
  args <- getArgs
  if null args then
    putStrLn ""
  else
    putStrLn $ reverse $ head args
