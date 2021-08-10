{-# OPTIONS_GHC -Wno-deferred-out-of-scope-variables #-}
{-# LANGUAGE OverloadedStrings #-}
module Main where

import Lib
import Mysql
import Database.MySQL.Base as DMB
import qualified Data.ByteString.Lazy.UTF8 as BLU hiding (ByteStribg,length, putStrLn, concatMap)
import qualified Data.ByteString as B (ByteString,readFile, concat, putStr, concatMap)
funC :: [FilePath] -> IO ([Query])
funC names= mapM f names
  where f x = do
          byteStr <- B.readFile x
          let querystr = "INSERT INTO uploaded_images (imageData) VALUES('?')"
              query = DMB.renderParams querystr $ DMB.render $ One (MySQLBytes byteStr)
          return query
main :: IO ()
main = do
  putStrLn "type filepath you want"
  path <- getLine
  names <- getRecursiveContents path
  putStrLn $ "Items to be commited to Database : " ++ show (length names)
  putStrLn "Type any to continue or Stop with C-c"
  temp <- getLine
  queries <- funC names
  --B.putStr $ B.concat (take 100 queries)
  --let flatFileContents = B.concat fileContents
  --B.putStr $ B.concat fileContents
  --putStrLn $ foldl (++) "" fileContents
  --let qStr = map (\x -> "INSERT INTO uploaded_images (imageData) VALUES('" ++ x ++ "')\n") fileContents
  --putStrLn qStr
  --insertData $ Query . BLU.fromString $ (show qStr)
  getDBInfo
