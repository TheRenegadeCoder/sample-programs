module Main where

import qualified Data.ByteString.Char8 as BC
import qualified Data.ByteString as BS
import Data.ByteString (ByteString)
import Data.Bits
import Data.Word (Word8)
import Data.Maybe (fromMaybe)
import System.Environment

alphabet :: ByteString
alphabet = BC.pack "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"

chunksOf :: Int -> ByteString -> [ByteString]
chunksOf n bs
  | BC.null bs = [] 
  | otherwise  = let (chunk, xs) = BC.splitAt n bs in chunk : chunksOf n xs 

get :: Int -> ByteString -> Word8
get i bs = if i >= BS.length bs then 0 else bs `BS.index` i

encode :: String -> String
encode = BC.unpack . BC.concat . map encodeChunk . chunksOf 3 . BC.pack
  where
  encodeChunk chunk  =
    let
      (b0, b1, b2) = (get 0 chunk, get 1 chunk, get 2 chunk)
      c0 = BC.index alphabet $ fromIntegral $ b0 `shiftR` 2
      c1 = BC.index alphabet $ fromIntegral $ (b0 .&. 0x03) `shiftL` 4 .|. b1 `shiftR` 4
      c2 = BC.index alphabet $ fromIntegral $ (b1 .&. 0x0F) `shiftL` 2 .|. b2 `shiftR` 6
      c3 = BC.index alphabet $ fromIntegral $ (b2 .&. 0x3F)
    in case BS.length chunk of
      3 -> BC.pack [c0, c1, c2, c3]
      2 -> BC.pack [c0, c1, c2, '=']
      1 -> BC.pack [c0, c1, '=', '=']
      _ -> BC.empty

decode :: String -> String
decode = BC.unpack . BC.concat . map decodeChunk . chunksOf 4 . BC.pack
  where
    charToVal w = fromIntegral $ fromMaybe 0 (BS.elemIndex w alphabet)
    decodeChunk chunk =
      let
          v0 = charToVal (get 0 chunk)
          v1 = charToVal (get 1 chunk)
          v2 = charToVal (get 2 chunk)
          v3 = charToVal (get 3 chunk)

          b0 = (v0 `shiftL` 2) .|. (v1 `shiftR` 4)
          b1 = ((v1 .&. 0x0F) `shiftL` 4) .|. (v2 `shiftR` 2)
          b2 = ((v2 .&. 0x03) `shiftL` 6) .|. v3
      in case BC.count '=' chunk of
        0 -> BS.pack [b0, b1, b2]
        1 -> BS.pack [b0, b1]
        2 -> BS.pack [b0]
        _ -> BS.empty

isBase64 :: String -> Bool
isBase64 str =  length str `mod` 4 == 0
             && all (`BC.elem` alphabet) b64
             && length padding <= 2
             && all (== '=') padding
  where (b64, padding) = break (== '=') str

main :: IO ()
main = do
  args <- getArgs
  case args of
    [_, ""]              -> putStrLn usage
    ["encode", inputStr] -> putStrLn $ encode inputStr
    ["decode", inputStr] ->
      if isBase64 inputStr
      then putStrLn $ decode inputStr
      else putStrLn usage
    _                    -> putStrLn usage
  where usage = "Usage: please provide a mode and a string to encode/decode" 
