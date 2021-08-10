{-# OPTIONS_GHC -Wno-deferred-out-of-scope-variables #-}
{-# LANGUAGE OverloadedStrings #-}
module Main where

import Lib
import Mysql
import Database.MySQL.Base as DMB
import Data.ByteString.Lazy.UTF8 as BLU hiding (length, putStrLn, concatMap)
main :: IO ()
main = do
  putStrLn "type filepath you want"
  path <- getLine
  names <- getRecursiveContents path
  putStrLn $ "Items to be commited to Database : " ++ show (length names)
  putStrLn "Type any to continue or Stop with C-c"
  temp <- getLine
  let qStr = concatMap (\x -> "INSERT INTO uploaded_images(imageType, imageData) VALUES('N/A', LOAD_FILE('" ++  x ++ "'))\n") names
  putStrLn qStr
  insertData $ Query . BLU.fromString $ qStr
  getDBInfo
