{-# LANGUAGE TupleSections #-}

module Main where

import Data.Map (Map)
import qualified Data.Map.Strict as Map
import System.Environment (getArgs)

duplicateCharacters :: String -> Map Char Int
duplicateCharacters = Map.filter (> 1) . Map.fromListWith (+) . map (, 1)

printDuplicates :: String -> Map Char Int -> IO ()
printDuplicates []     _ = return ()
printDuplicates (x:xs) m =
  case Map.updateLookupWithKey (\_ _ -> Nothing) x m of
    (Just count, m') -> putStrLn (x : ": " ++ show count) >> printDuplicates xs m'
    _                -> printDuplicates xs m

main :: IO ()
main = do
  args <- getArgs
  case args of
    [xs@(_:_)] ->
      let m = duplicateCharacters xs
      in if Map.null m
          then putStrLn "No duplicate characters"
          else printDuplicates xs m
    _          -> putStrLn "Usage: please provide a string"

