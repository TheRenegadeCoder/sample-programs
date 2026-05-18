module Main where

import Data.Array (Array, (!))
import qualified Data.Array as Array
import Text.Read (readMaybe)
import Control.Monad (guard)
import Data.IntSet (IntSet)
import qualified Data.IntSet as IS
import Data.Set (Set)
import qualified Data.Set as Set
import System.Environment

stringToListMaybe :: String -> Maybe [Int]
stringToListMaybe str = readMaybe $ "[" ++ str ++ "]" :: Maybe [Int]

chunksOf :: Int -> [Int] -> [[Int]]
chunksOf _ [] = []
chunksOf n l  = let (row, xs) = splitAt n l in row : chunksOf n xs

buildAdjacencyMatrix :: [Int] -> Array Int [Int]
buildAdjacencyMatrix l = Array.listArray (0, n-1) (chunksOf n l)
  where
  n = round (sqrt (fromIntegral (length l))) -- size of a row in a square matrix

prim :: Array Int [Int] -> Int
prim adj = go IS.empty (Set.singleton (0, 0))
  where 
  go vis pq
    | Set.null pq = 0
    | otherwise   =
        let ((weight, v), pq') = Set.deleteFindMin pq
        in if IS.member v vis
           then go vis pq'
           else 
             let pq'' = foldr Set.insert pq' (unvisitedEdges v vis)
             in weight + go (IS.insert v vis) pq''
  unvisitedEdges v vis =
    [ (weight, u)
    | (weight, u) <- zip (adj ! v) [0..]
    , weight /= 0, u `IS.notMember` vis
    ]
      
parseArgs :: [String] -> Maybe [Int]
parseArgs [l] = do
  l <- stringToListMaybe l 
  guard $ (not . null) l && isSquare (length l)
  return l
  where isSquare n = (round $ sqrt $ fromIntegral n) ^ 2 == n
parseArgs _ = Nothing

main :: IO ()
main = do
  args <- getArgs
  case parseArgs args of
    Nothing -> putStrLn "Usage: please provide a comma-separated list of integers"
    Just l  -> print $ prim (buildAdjacencyMatrix l)
