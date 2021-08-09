{-# OPTIONS_GHC -Wno-deferred-out-of-scope-variables #-}
module Main where

import Lib
main :: IO ()
main = do
  putStrLn "type filepath you want"
  path <- getLine
  names <- getRecursiveContents path
  putStrLn (unlines names)
