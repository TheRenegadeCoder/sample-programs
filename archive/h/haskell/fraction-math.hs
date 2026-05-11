module Main where

import System.Environment
import Text.Read
import Data.Bifunctor (second)
import Data.Ratio

parseOperator :: String -> Maybe (Rational -> Rational -> Rational)
parseOperator op = lookup op operators
  where
  -- converts relational operations that return bool, to operations that return rationals - 1 for True, 0 for False
  relationalToRational f a b = toRational $ fromEnum (f a b)
  arithmeticOps = [("+", (+)), ("-", (-)), ("/", (/)), ("*", (*))]
  relationalOps = [(">", (>)), ("<", (<)), (">=", (>=)), ("<=", (<=)), ("==", (==)), ("!=", (/=))]
  operators = arithmeticOps ++ map (second relationalToRational) relationalOps

parseFraction :: String -> Maybe Rational
parseFraction s = do
  let (num, den) = break (== '/') s
  num' <- readMaybe num
  den' <- readMaybe (drop 1 den) -- drop 1 for the '/'
  return (num' % den')

applyOperator :: [String] -> Maybe Rational
applyOperator [frac1, op, frac2] = do
  operand1 <- parseFraction frac1
  operand2 <- parseFraction frac2
  operator <- parseOperator op
  return (operand1 `operator` operand2)
applyOperator _ = Nothing

rationalToString :: Rational -> String
rationalToString x
  | denominator x == 1 = show (numerator x)
  | otherwise          = show (numerator x) ++ "/" ++ show (denominator x)

main :: IO ()
main = do
  args <- getArgs
  case applyOperator args of
    Just res -> putStrLn (rationalToString res)
    Nothing  -> putStrLn "Usage: ./fraction-math operand1 operator operand2"
