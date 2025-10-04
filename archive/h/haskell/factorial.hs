module Main where

import System.Environment
import Text.Read

factorial :: Integer -> Integer
factorial 0 = 1
factorial n = n * factorial (n - 1)

headMaybe :: [a] -> Maybe a
headMaybe [] = Nothing
headMaybe (x:xs) = Just x

main :: IO ()
main = do
  args <- getArgs
  let n = headMaybe args
  case n >>= readMaybe of
    Nothing -> putStrLn "Usage: please input a non-negative integer"
    Just n
      | n < 0       -> putStrLn "Usage: please input a non-negative integer"
      | n <= 250000 -> putStrLn $ take 10 $ show $ factorial n
      | otherwise   -> putStrLn $ "!" ++ (show n) ++ " is out of the reasonable bounds for calculation"
