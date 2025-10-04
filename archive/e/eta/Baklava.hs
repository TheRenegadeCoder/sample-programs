module Main where

baklavaLine :: Int -> String
baklavaLine n = (replicate numSpaces ' ') ++ (replicate numStars '*') ++ "\n"
    where
        numSpaces = abs(n - 10)
        numStars = 21 - 2 * numSpaces

baklava :: String -> Int -> String
baklava s 0 = s ++ baklavaLine 0
baklava s n = s ++ baklavaLine n ++ baklava s (n - 1)

main :: IO ()
main = putStr (baklava "" 20)
