module Main where

import Data.IntSet (IntSet)
import qualified Data.IntSet as IS
import Data.IntMap (IntMap)
import qualified Data.IntMap.Strict as IM
import Control.Monad (guard, forM)
import Control.Monad.State
import Text.Read (readMaybe)
import Data.Maybe (fromMaybe)
import System.Environment

stringToListMaybe :: String -> Maybe [Int]
stringToListMaybe str = readMaybe $ "[" ++ str ++ "]" :: Maybe [Int]

parseArgs :: [String] -> Maybe ([Int], [Int], Int)
parseArgs [tree, vertices, target] = do
  tree     <- stringToListMaybe tree
  vertices <- stringToListMaybe vertices
  target   <- readMaybe target
  guard $ (not . null) tree
  guard $ (not . null) vertices
  guard (length vertices ^ 2 == length tree)
  return (tree, vertices, target)
parseArgs _ = Nothing

-- builds a map where the vertices are the keys and the values are lists of neighboring vertices
buildAdjencyMap :: [Int] -> [Int] -> IntMap [Int]
buildAdjencyMap tree vertices = IM.fromListWith (++) [(u, [v]) | (1, (u, v)) <- zip tree coordinates]
  where coordinates = [(u, v) | u <- vertices, v <- vertices]

dfs :: IntMap [Int] -> Int -> Int -> Bool
dfs adj start target = evalState (go start) IS.empty
  where
  go :: Int -> State IntSet Bool
  go n | n == target = return True
  go n = do
    vis <- get
    if IS.member n vis
    then
      return False
    else do
      modify (IS.insert n)
      let neighs = fromMaybe [] $ IM.lookup n adj
      res <- forM neighs go
      return (or res)

main :: IO ()
main = do
  args <- getArgs
  case parseArgs args of
    Nothing -> putStrLn "Usage: please provide a tree in an adjacency matrix form (\"0, 1, 1, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 1, 1, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0\") together with a list of vertex values (\"1, 3, 5, 2, 4\") and the integer to find (\"4\")"
    Just (tree, vertices@(v:_), target) ->
      let adj = buildAdjencyMap tree vertices
      in putStrLn $ if dfs adj v target then "true" else "false"
