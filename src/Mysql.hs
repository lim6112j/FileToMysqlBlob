{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ScopedTypeVariables #-}
module Mysql(getDBInfo, insertData) where
import Database.MySQL.Base
import qualified System.IO.Streams as Streams
import qualified Data.ByteString as B
getDBInfo :: IO()
getDBInfo = do
  conn <- connect
    defaultConnectInfo {ciHost="133.186.212.161", ciPort=3306, ciUser = "root", ciPassword = "thecheat99))", ciDatabase = "thecheat_api"}
  (defs, is) <- query_ conn "SELECT * FROM uploaded_images limit 1"
  print =<< Streams.toList is
insertData  = do
  conn <- connect
    defaultConnectInfo {ciHost="133.186.212.161", ciPort=3306, ciUser = "root", ciPassword = "thecheat99))", ciDatabase = "thecheat_api"}
  execute conn "INSERT INTO uploaded_images(imageData) VALUES(?)" [MySQLBytes "123123123"]
