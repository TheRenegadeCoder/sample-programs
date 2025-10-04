module Main where

main :: IO ()
main = putStrLn baklava

-- Create baklava where the top has 10 spaces and then 1 asterisk
baklava ::  String
baklava = baklavaGrow 10 1

-- Recursively grow the baklava until spaces <= zero
baklavaGrow :: Int -> Int -> String
baklavaGrow space asterisk
  | space <= 0 = line 0     asterisk ++ "\n" ++ baklavaShrink 1          (asterisk - 2)
  | otherwise  = line space asterisk ++ "\n" ++ baklavaGrow   (space - 1) (asterisk + 2)

-- Recursively shrink the baklava until asterisks <= zero
baklavaShrink :: Int -> Int -> String
baklavaShrink space asterisk
  | asterisk <= 1 = line space 1
  | otherwise     = line space asterisk ++ "\n" ++ baklavaShrink (space + 1) (asterisk - 2)

-- Return a single line of the baklava
line space asterisk = replicate space ' ' ++ replicate asterisk '*'
