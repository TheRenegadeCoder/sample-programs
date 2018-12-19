-- This implementation requires ArgParser. It can be installed using cabal install argparser

-- Any live cell with fewer than two live neighbors dies, as if caused by underpopulation.
-- Any live cell with two or three live neighbors lives on to the next generation.
-- Any live cell with more than three live neighbors dies, as if by overpopulation.
-- Any dead cell with exactly three live neighbors becomes a live cell, as if by reproduction.

module Main where

import System.Console.ArgParser
import System.Environment
import Control.Concurrent
import Control.Applicative


type Position = (Int, Int)

data Node = Alive Position | Dead Position deriving (Show, Eq)

type Grid = [Node]

type Game = [Grid]

class GridMember a where
  -- | 'circle' provides the eight positions that surround a GridMember
  circle :: a -> [Position]
  -- | 'getX' returns the x coordinate of a GridMember
  getX :: a -> Int
  -- | 'getY' returns the y coordinate of a GridMember
  getY :: a -> Int

instance GridMember Node where
  circle (Alive (x, y)) = [(x1, y1) | x1 <- [x-1..x+1], y1 <- [y-1..y+1], (x1,y1) /= (x,y)]
  circle _ = []
  getX (Alive (x, _)) = x
  getX (Dead (x, _)) = x
  getY (Alive (_, y)) = y
  getY (Dead (_, y)) = y

class Cell a where
  -- | 'isAlive' determines whether a cell is alive
  isAlive :: a -> Bool
  -- | 'kill' kills a cell
  kill :: a -> a
  -- | 'birth' brings a cell to life
  birth :: a -> a
  -- | 'atPosition' determines whether a cell is alive and at a given position
  atPosition :: a -> Position ->  Bool
  -- | 'inGrid' determines if a cell is alive and located within a given list of positions
  inGrid :: a -> [Position] -> Bool
  -- | 'neighbors' determines all living neighbors of a cell
  neighbors :: a -> [a] ->  [a]
  -- | 'cellStep' determines whether a cell will be alive or dead in the next iteration
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


-- | 'makeGrid' takes a width and a spawn rate and greats a grid with nodes spawned
makeGrid :: Int -> Float -> Grid
makeGrid width spawnRate = spawn [Dead (x, y) | x <- [0..(width-1)], y <- [0..(width-1)]] $ getSpawnIndexes width spawnRate
  where getSpawnIndexes :: Int -> Float -> [Int]
        getSpawnIndexes width spawnRate = let max = width ^ 2
                                          in map floor $ tail [0,(100 / (100 * spawnRate))..(fromIntegral max)]

-- | 'spawn' takes a Grid and a list of indexes in the grid at which Nodes should spawn.
-- It returns a Grid with Nodes spawned at those indexes.
spawn :: Grid -> [Int] -> Grid
spawn grid indexes = spawn' grid indexes 0
  where spawn' [] _ _ = []
        spawn' _ [] _ = []
        spawn' (c:cs) (i:indexes) count
          | i == count = (birth c):spawn' cs indexes     (count + 1)
          | otherwise  =         c:spawn' cs (i:indexes) (count + 1)

-- | 'simulate' takes a number of frames and a grid and iterates that grid frame times
simulate :: Int -> Grid -> Game
simulate 0 grid        = []
simulate frameNum grid = grid:simulate (frameNum - 1) (step grid)
  where step :: Grid -> Grid
        step grid = map (flip cellStep grid) grid

-- | 'GoL' is a record for parsing the command line arguments.
-- It takes 3 Int: width, framerate, and frames
-- and one float: spawn percentage
data GoL = GoL Int Int Int Float deriving (Show)

-- | 'golParser' is the ArgParser parser spec for the GoL record
golParser :: ParserSpec GoL
golParser = GoL
  `parsedBy` reqPos "width"     `Descr` "Grid width (assume square grid)"
  `andBy`    reqPos "framerate" `Descr` "Frame rate (frames/second)"
  `andBy`    reqPos "frames"    `Descr` "Total number of frames"
  `andBy`    reqPos "spawn"     `Descr` "Spawn rate (% of living vs. dead as decimal between 0 and 1)"

-- | 'golInterface' is the entrypoint for ArpParse's CLI parsing
golInterface :: IO (CmdLnInterface GoL)
golInterface =
  (`setAppDescr` "Game of Life in Haskell")
  <$> mkApp golParser

-- | 'runGameIO' is the entrypoint for running the game itself
-- It takes all the CLI parameters from 'GoL' and uses them to
-- instantiate a grid, simulate a game, and print the simulation
-- out to the console
runGameIO :: GoL -> IO ()
runGameIO (GoL width framerate frames spawn) = do
  let grid = makeGrid width spawn
  let game = simulate frames grid
  printGame framerate game

-- | 'printGame' takes a delay (in seconds) and a game and prints 
-- out each iteration of the game with the specified delay
-- in between each print
printGame :: Int -> Game -> IO ()
printGame _ [] = putStrLn ""
printGame delaySeconds (g:gs) = do
  clearScreen
  printGrid g
  threadDelay (delaySeconds * 1000000)
  printGame delaySeconds gs

-- | 'printGrid' prints a single grid to the console
printGrid :: Grid -> IO ()
printGrid grd = mapM_ putStrLn $ rowStrings grd

-- | 'rowStrings' converts a 'Grid' to a list of strings
-- where each element in the list is a single row
-- of the grid
rowStrings :: Grid -> [String]
rowStrings grd = reverse $ snd $ foldl go (0,[]) grd
  where go (row, []) n = (row, [strNode n])
        go (row, acc@(a:as)) n
          | getX n == row = (row, (a ++ "." ++ strNode n):as)
          | otherwise     = (row+1, (strNode n):acc)

-- | 'strNode' converts a single node to a single character string
-- "0" means dead "x" means alive
strNode :: Node -> String
strNode (Dead _)  = "0"
strNode (Alive _) = "x"


-- | 'clearScreen' prints 1000 empty lines to the console, effictively
-- clearing the console window. There are good alternatives to this method
-- but they are either platform specific or require a library
clearScreen :: IO ()
clearScreen = mapM_ putStrLn $ replicate 1000 " "


-- | 'main' is the entrypoint of the program
main :: IO ()
main = do
  interface <- golInterface
  runApp interface runGameIO

