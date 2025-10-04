module Main where

import System.Environment
import Text.Read

isPrime :: Integral a => a -> Bool
isPrime 0 = False
isPrime 1 = False
isPrime 2 = True
isPrime x = null [n | n <- 2:[3,5..integralSqrt x], x `mod` n == 0]
  where integralSqrt = round . sqrt .fromIntegral

output :: Bool -> String
output True = "Prime"
output False = "Composite"

headMaybe :: [a] -> Maybe a
headMaybe [] = Nothing
headMaybe (x:xs) = Just x

main :: IO ()
main = do
  args <- getArgs
  let x = headMaybe args
  case x >>= readMaybe of
    Nothing -> putStrLn "Usage: please input a non-negative integer"
    Just x
      | x < 0       -> putStrLn "Usage: please input a non-negative integer"
      | otherwise   -> putStrLn $ output $ isPrime x
