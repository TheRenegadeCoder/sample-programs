
module Main where

import System.Environment
import Text.Read
import Data.List (transpose, intercalate)
import Data.Function ((&))
import Control.Monad (guard)

-- Converts string in format "1, 2, 3" to a Maybe list of int
stringToListMaybe :: String -> Maybe [Int]
stringToListMaybe str = readMaybe $ "[" ++ str ++ "]" :: Maybe [Int]

listToMatrix :: Int -> [Int] -> [[Int]]
listToMatrix _ [] = []
listToMatrix n l  = let (row, xs) = splitAt n l in row : listToMatrix n xs

listToString :: (Show a) => [a] -> String
listToString = intercalate ", " . map show

parseArgs :: [String] -> Maybe (Int, Int, [Int])
parseArgs [cols, rows, list] = do
  cols' <- readMaybe cols
  rows' <- readMaybe rows
  list' <- stringToListMaybe list
  guard $ cols' > 0 && rows' > 0 && cols' * rows' == length list'
  return (cols', rows', list')
parseArgs _ = Nothing

main :: IO ()
main = do
  args <- getArgs
  case parseArgs args of
    Nothing        -> putStrLn "Usage: please enter the dimension of the matrix and the serialized matrix"
    Just (c, _, l) -> listToMatrix c l & transpose & concat & listToString & putStrLn
