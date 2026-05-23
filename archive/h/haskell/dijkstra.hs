module Main where

import Data.Array (Array, (!))
import qualified Data.Array as Array
import Data.Set (Set)
import qualified Data.Set as Set
import Text.Read (readMaybe)
import Control.Monad (guard)
import System.Environment (getArgs)

type AdjacencyMatrix = Array Int [Int]

stringToListMaybe :: String -> Maybe [Int]
stringToListMaybe str = readMaybe $ "[" ++ str ++ "]" :: Maybe [Int]

chunksOf :: Int -> [Int] -> [[Int]]
chunksOf _ [] = []
chunksOf n l  = let (row, xs) = splitAt n l in row : chunksOf n xs

buildAdjacencyMatrix :: [Int] -> Array Int [Int]
buildAdjacencyMatrix l = Array.listArray (0, n-1) (chunksOf n l)
  where
  n = round (sqrt (fromIntegral (length l))) -- size of a row in a square matrix

dijkstra :: AdjacencyMatrix -> Int -> Int -> Maybe Int
dijkstra adj src dst = go Set.empty (Set.singleton (0, src))
  where 
  go vis pq
    | Set.null pq = Nothing
    | otherwise   =
        let ((dist, v), pq') = Set.deleteFindMin pq in
        if v == dst
          then Just dist
        else if Set.member v vis
          then go vis pq'
        else 
           go (Set.insert v vis) (foldr Set.insert pq' $ unvisitedEdges v dist vis)

  unvisitedEdges v dist vis =
    [ (weight + dist, u)
    | (weight, u) <- zip (adj ! v) [0..]
    , weight /= 0, u `Set.notMember` vis
    ]

parseArgs :: [String] -> Maybe (AdjacencyMatrix, Int, Int)
parseArgs [adj, src, dst] = do
  adj <- stringToListMaybe adj
  src <- readMaybe src
  dst <- readMaybe dst
  let len      = length adj
  let vertices = round (sqrt $ fromIntegral len)
  guard ((not . null) adj && vertices ^ 2 == len) -- check that the list can be turned into a square matrix
  guard (all (>= 0) adj)
  guard (src >= 0 && src < vertices && dst >= 0 && dst < vertices)
  return (buildAdjacencyMatrix adj, src, dst)
parseArgs _ = Nothing

main :: IO ()
main = do
  args <- getArgs
  case parseArgs args >>= \(adj, src, dst) -> dijkstra adj src dst of
    Nothing -> putStrLn "Usage: please provide three inputs: a serialized matrix, a source node and a destination node"
    Just res -> print res
