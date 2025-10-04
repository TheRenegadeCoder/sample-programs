module Main where

import Prelude
import Effect (Effect)
import Effect.Console (log)

main :: Effect Unit
main = do
    baklava (-10) 10

baklava :: Int -> Int -> Effect Unit
baklava n ne
    | n > ne = pure unit
    | otherwise = do
        log (baklavaLine n)
        baklava (n + 1) ne

baklavaLine :: Int -> String
baklavaLine n = do
    let numSpaces = abs n
    let numStars = 21 - 2 * numSpaces
    (repeatString numSpaces " ") <> (repeatString numStars "*")

abs :: Int -> Int
abs n
    | n < 0 = -n
    | otherwise = n

repeatString :: Int -> String -> String
repeatString n s
    | n < 1 = ""
    | otherwise = s <> repeatString (n - 1) s
