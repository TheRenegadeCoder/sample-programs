module Main where

import System.Environment

-- Recursively find longest common subsequence
lcs :: Eq a => [a] -> [a] -> [a]
lcs [] bs = []
lcs as [] = []
lcs (a:as) (b:bs)
  | a == b    = (lcs as bs) ++ [a]
  | otherwise = longest (lcs (a:as) bs) (lcs as (b:bs))


-- Returns the longer of two lists
longest :: Foldable t => t a -> t a -> t a
longest l1 l2
  | length l1 > length l2 = l1
  | otherwise             = l2


-- Converts string in format "1, 2, 3" to a list of integers
stringToList :: String -> [Int]
stringToList str = read $ "[" ++ str ++ "]" :: [Int]


main :: IO ()
main = do
  args <- getArgs
  let l1 = stringToList $ head args :: [Int]
  let l2 = stringToList $ head $ tail args :: [Int]
  if length args /= 2 then
    error "You need to pass two lists of which to produce the lcs. For example ./lcs \"1, 4, 5, 3, 15, 6\" \"1, 7, 4, 5, 11, 6\"\n"
  else
    let message    = "\nThe longest common subsequence of " ++ (show l1) ++ " and " ++ (show l2) ++ " is "
        subsequence = reverse $ lcs l1 l2
    in putStrLn $ message ++ show subsequence
