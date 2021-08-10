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
  paths <- getRecursiveDirectoryContents path
  putStrLn $ "Items to be commited to Database : " ++ show (length paths)
  byteStrs <- readPath paths
  oks <- insertData byteStrs
  putStrLn oks
