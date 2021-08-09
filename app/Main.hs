{-# OPTIONS_GHC -Wno-deferred-out-of-scope-variables #-}
module Main where

import Lib
import Mysql
main :: IO ()
main = do
  putStrLn "type filepath you want"
  path <- getLine
  names <- getRecursiveContents path
  fileContents <- mapM readFile names
  putStrLn $ concatMap (\x -> "INSERT INTO DB (ID, IMAGE) VALUES(" ++ x ++ ")\n") fileContents
  getDBInfo
