-- This implementation requires ArgParser. It can be installed using cabal install argparser
module Main where

import           Control.Applicative
import           Control.Concurrent
import           Control.Monad            (replicateM_)
import           System.Console.ArgParser
import           System.Environment

type Position = (Int, Int)

data Node
  = Alive Position Int
  | Dead Position Int
  deriving (Show, Eq)

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
  circle (Alive (x, y) w) = map wrap
    [ (x1, y1)
    | x1 <- [x - 1 .. x + 1]
    , y1 <- [y - 1 .. y + 1]
    , (x1, y1) /= (x, y)
    ]
      where wrap (x', y') = (go x', go y')
            go n
              | n < 0     = w - 1
              | n > w     = 0
              | otherwise = n
  circle _ = []
  getX (Alive (x, _) _) = x
  getX (Dead (x, _) _)  = x
  getY (Alive (_, y) _) = y
  getY (Dead (_, y) _)  = y

class Cell a where
  -- | 'isAlive' determines whether a cell is alive
  isAlive :: a -> Bool
  -- | 'kill' kills a cell
  kill :: a -> a
  -- | 'birth' brings a cell to life
  birth :: a -> a
  -- | 'atPosition' determines whether a cell is alive and at a given position
  atPosition :: a -> Position -> Bool
  -- | 'inGrid' determines if a cell is alive and located within a given list of positions
  inGrid :: a -> [Position] -> Bool
  -- | 'neighbors' determines all living neighbors of a cell
  neighbors :: a -> [a] -> [a]
  -- | 'cellStep' determines whether a cell will be alive or dead in the next iteration
  cellStep :: a -> [a] -> a

instance Cell Node where
  isAlive (Alive _ _) = True
  isAlive (Dead _ _)  = False
  kill (Alive (x, y) w) = Dead (x, y) w
  kill (Dead (x, y) w)  = Dead (x, y) w
  birth (Alive (x, y) w) = Alive (x, y) w
  birth (Dead (x, y) w)  = Alive (x, y) w
  atPosition (Alive (x, y) w) (x1, y1) = x == x1 && y == y1
  atPosition _ _                       = False
  inGrid cell ps = or $ fmap (atPosition cell) ps
  neighbors cell cells =
    let cellGrid = circle cell
     in filter (`inGrid` circle cell) cells
  cellStep cell grid =
    let numNeighbors = length $ neighbors cell grid
     in cellStep' numNeighbors cell
    where
      cellStep' numNeighbors cell
        | numNeighbors < 2 || numNeighbors > 3 = kill cell
        | numNeighbors == 3 = birth cell
        | otherwise = cell

-- | 'makeGrid' takes a width and a spawn rate and greats a grid with nodes spawned
makeGrid :: Int -> Float -> Grid
makeGrid width spawnRate =
  spawn [Dead (x, y) width | x <- [0 .. (width - 1)], y <- [0 .. (width - 1)]] $
  getSpawnIndexes width spawnRate
  where
    getSpawnIndexes :: Int -> Float -> [Int]
    getSpawnIndexes width spawnRate =
      let max = width ^ 2
       in map floor $ tail [0,(100 / (100 * spawnRate)) .. (fromIntegral max)]

-- | 'spawn' takes a 'Grid' and a list of indexes in the 'grid' at which Nodes should spawn.
-- It returns a 'Grid' with Nodes spawned at those indexes.
spawn :: Grid -> [Int] -> Grid
spawn grid indexes = go grid indexes 0
  where
    go [] _ _ = []
    go _ [] _ = []
    go (c:cs) (i:indexes) count
      | i == count = birth c : go cs indexes (count + 1)
      | otherwise = c : go cs (i : indexes) (count + 1)

-- | 'simulate' takes a number of frames and a 'Grid' and iterates that 'Grid' frame times
simulate :: Int -> Grid -> Game
simulate 0 grid = []
simulate frameNum grid = grid : simulate (frameNum - 1) (step grid)
  where
    step :: Grid -> Grid
    step grid = map (`cellStep` grid) grid

-- | 'GoL' is a record for parsing the command line arguments.
-- It takes 3 'Int': width, framerate, and frames
-- and one 'Float': spawn percentage
data GoL =
  GoL Int
      Int
      Int
      Float
  deriving (Show)

-- | 'golParser' is the ArgParser 'ParserSpec' for the 'GoL' record
golParser :: ParserSpec GoL
golParser =
  GoL `parsedBy` reqPos "width" `Descr` "Grid width (assume square grid)" `andBy`
  reqPos "framerate" `Descr`
  "Frame rate (frames/second)" `andBy`
  reqPos "frames" `Descr`
  "Total number of frames" `andBy`
  reqPos "spawn" `Descr`
  "Spawn rate (% of living vs. dead as decimal between 0 and 1)"

-- | 'golInterface' is the entrypoint for ArpParse's CLI parsing
golInterface :: IO (CmdLnInterface GoL)
golInterface = (`setAppDescr` "Game of Life in Haskell") <$> mkApp golParser

-- | 'runGameIO' is the entrypoint for running the game itself
-- It takes all the CLI parameters from 'GoL' and uses them to
-- instantiate a 'Grid', simulate a 'Game', and print the simulation
-- out to the console
runGameIO :: GoL -> IO ()
runGameIO (GoL width framerate frames spawn) = do
  let grid = makeGrid width spawn
  let game = simulate frames grid
  printGame framerate game

-- | 'printGame' takes a delay (in seconds) and a 'Game' and prints
-- out each iteration of the 'Game' with the specified delay
-- in between each print
printGame :: Int -> Game -> IO ()
printGame _ [] = putStrLn ""
printGame delaySeconds (g:gs) = do
  clearScreen
  printGrid g
  threadDelay (delaySeconds * 1000000)
  printGame delaySeconds gs

-- | 'printGrid' prints a single 'Grid' to the console
printGrid :: Grid -> IO ()
printGrid grd = mapM_ putStrLn $ rowStrings grd

-- | 'rowStrings' converts a 'Grid' to a list of 'String'
-- where each element in the list is a single row
-- of the 'Grid'
rowStrings :: Grid -> [String]
rowStrings grd = reverse $ snd $ foldl go (0, []) grd
  where
    go (row, []) n = (row, [strNode n])
    go (row, acc@(a:as)) n
      | getX n == row = (row, (a ++ "." ++ strNode n) : as)
      | otherwise = (row + 1, strNode n : acc)

-- | 'strNode' converts a single 'Node' to a single character 'String'
-- where "0" means dead "x" means alive
strNode :: Node -> String
strNode (Dead _ _)  = "0"
strNode (Alive _ _) = "x"

-- | 'clearScreen' prints 1000 empty lines to the console, effictively
-- clearing the console window. There are good alternatives to this method
-- but they are either platform specific or require a library
clearScreen :: IO ()
clearScreen = replicateM_ 1000 (putStrLn " ")

-- | 'main' is the entrypoint of the program
main :: IO ()
main = do
  interface <- golInterface
  runApp interface runGameIO
