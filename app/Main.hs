{-# OPTIONS_GHC -Wno-deferred-out-of-scope-variables #-}
module Main where

import Lib
import Mysql
main :: IO ()
main = do
  putStrLn "type filepath you want"
  path <- getLine
  names <- getRecursiveContents path
  putStrLn $ "Items to be commited to Database : " ++ show (length names)
  putStrLn "Type any to continue or Stop with C-c"
  temp <- getLine
  putStrLn $ concatMap (\x -> "INSERT INTO db (id, imageBlob) VALUES(1, LOAD_FILE('" ++  x ++ "'))\n") names
  getDBInfo
