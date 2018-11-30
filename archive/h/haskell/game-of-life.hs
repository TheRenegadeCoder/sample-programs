module Main where

import System.Console.ArgParser
import System.Environment
--import Text.Read
import Control.Concurrent
import Control.Applicative

--Any live cell with fewer than two live neighbors dies, as if caused by underpopulation.
--Any live cell with two or three live neighbors lives on to the next generation.
--Any live cell with more than three live neighbors dies, as if by overpopulation.
--Any dead cell with exactly three live neighbors becomes a live cell, as if by reproduction.


type Position = (Int, Int)

data Node = Alive Position | Dead Position deriving (Show, Eq)

type Grid = [Node]

type Game = [Grid]

class GridMember a where
  circle :: a -> [Position]

instance GridMember Node where
  circle (Alive (x, y)) = [(x1, y1) | x1 <- [x-1..x+1], y1 <- [y-1..y+1], (x1,y1) /= (x,y)]
  circle _ = []

class Cell a where
  isAlive :: a -> Bool
  kill :: a -> a
  birth :: a -> a
  atPosition :: a -> Position ->  Bool
  inGrid :: a -> [Position] -> Bool
  neighbors :: a -> [a] ->  [a]
  cellStep :: a -> [a] -> a

instance Cell Node where
  isAlive (Alive _) = True
  isAlive (Dead  _) = False

  kill (Alive (x, y)) = Dead (x, y)
  kill (Dead (x, y)) = Dead (x, y)

  birth (Alive (x,y)) = Alive (x, y)
  birth (Dead (x, y)) = Alive (x, y)

  atPosition (Alive (x, y)) (x1, y1) = x == x1 && y == y1
  atPosition _ _ = False

  inGrid cell ps = any (\b -> b) $ fmap (atPosition cell) ps

  neighbors cell cells =
    let cellGrid = circle cell
    in filter (flip inGrid (circle cell)) cells

  cellStep cell grid =
    let numNeighbors = length $ neighbors cell grid
    in cellStep' numNeighbors cell
      where cellStep' numNeighbors cell
              | numNeighbors < 2 || numNeighbors > 3 = kill cell
              | numNeighbors == 3                    = birth cell
              | otherwise                            = cell


makeGrid :: Int -> Float -> Grid
makeGrid width spawnRate = spawn [Dead (x, y) | x <- [0..(width-1)], y <- [0..(width-1)]] $ getSpawnIndexes width spawnRate

getSpawnIndexes :: Int -> Float -> [Int]
getSpawnIndexes width spawnRate =
  let max = width ^ 2
  in map floor $ tail [0,(100 / (100 * spawnRate))..(fromIntegral max)]

spawn :: Grid -> [Int] -> Grid
spawn grid indexes = spawn' grid indexes 0
  where spawn' [] _ _ = []
        spawn' _ [] _ = []
        spawn' (c:cs) (i:indexes) count
          | i == count = (birth c):spawn' cs indexes     (count + 1)
          | otherwise  =         c:spawn' cs (i:indexes) (count + 1)

step :: Grid -> Grid
step grid = map (flip cellStep grid) grid


simulate :: Int -> Grid -> Game
simulate 0 grid        = []
simulate frameNum grid = grid:simulate (frameNum - 1) (step grid)

indexMaybe xs index
  | length xs < index = Just (xs !! index)
  | otherwise         = Nothing

data GoL = GoL Int Int Int Float deriving (Show)

golParser :: ParserSpec GoL
golParser = GoL
  `parsedBy` reqPos "width"  `Descr` "Grid width (assume square grid)"
  `andBy`    reqPos "framerate"   `Descr` "Frame rate (frames/second)"
  `andBy`    reqPos "frames" `Descr` "Total number of frames"
  `andBy`    reqPos "spawn"  `Descr` "Spawn rate (% of living vs. dead as decimal between 0 and 1)"

golInterface :: IO (CmdLnInterface GoL)
golInterface =
  (`setAppDescr` "Game of Life in Haskell")
  <$> mkApp golParser

runGame :: GoL -> Game
runGame (GoL width framerate frames spawn) =
  let grid = makeGrid width spawn
  in simulate frames grid

runGameIO :: GoL -> IO ()
runGameIO = putStrLn . show . runGame

gridString :: Grid -> Int -> String
gridString grid width = gridString' grid width 0
  where gridString' [] _ _ = ""
        gridString' (g:gs) width column
          | column + 1 >= width =         show g ++ gridString' gs width 1
          | otherwise           = "\n" ++ show g ++ gridString' gs width 0

main :: IO ()
main = do
  interface <- golInterface
  runApp interface runGameIO

--main :: IO ()
--main = do
--  args <- getArgs
--  let width = indexMaybe 0 args
--  let frameRate = indexMaybe 1 args
--  let frameNum = indexMaybe 2 args
--  let spawnRate = indexMaybe 3 args
--  case n >>= readMaybe of
--    Nothing -> putStrLn "Usage: please input a non-negative integer"
--    Just n -> putStrLn n

--threadDelay 1000000


--Grid width (assume square grid)
--Frame rate (frames/second)
--Total number of frames
--Spawn rate (% of living vs. dead as decimal between 0 and 1)
