{-# OPTIONS_GHC -Wno-deferred-out-of-scope-variables #-}
{-# LANGUAGE OverloadedStrings #-}
{-# OPTIONS_GHC -XDataKinds#-}
module Main where

import Lib
import Mysql
import Database.MySQL.Base as DMB
import qualified Data.ByteString as B
readPath :: [FilePath] -> IO ([B.ByteString])
readPath = mapM f
  where f x = do
          byteStr <- B.readFile x
          return byteStr
main :: IO ()
main = do
  putStrLn "type filepath you want"
  path <- getLine
  paths <- getRecursiveContents path
  putStrLn $ "Items to be commited to Database : " ++ show (length paths)
  putStrLn "Type any to continue or Stop with C-c"
  --byteStrs <- readPath paths
  --putStrLn $ show byteStrs
  insertData
  --B.putStr $ B.concat (take 100 queries)
  --let flatFileContents = B.concat fileContents
  --B.putStr $ B.concat fileContents
  --putStrLn $ foldl (++) "" fileContents
  --let qStr = map (\x -> "INSERT INTO uploaded_images (imageData) VALUES('" ++ x ++ "')\n") fileContents
  --putStrLn qStr
  --insertData $ Query . BLU.fromString $ (show qStr)
  getDBInfo
