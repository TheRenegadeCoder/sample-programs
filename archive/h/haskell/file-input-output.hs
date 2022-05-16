module Main where

import System.IO

main :: IO ()
main = do
  -- write
  handle <- openFile "output.txt" ReadWriteMode
  hPutStr handle "file contents"
  hClose handle
  -- read
  handle <- openFile "output.txt" ReadWriteMode
  value <- hGetContents handle
  -- Print the contents of the file that was read.
  -- Haskell reads the file lazily, so the value must be printed before the handle is closed
  putStrLn value
  hClose handle
