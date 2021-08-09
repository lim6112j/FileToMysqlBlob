{-# LANGUAGE OverloadedStrings #-}

module Mysql(getDBInfo) where
import Database.MySQL.Base
import qualified System.IO.Streams as Streams
getDBInfo :: IO()
getDBInfo = do
  conn <- connect
    defaultConnectInfo {ciHost="127.0.0.1", ciPort=3306, ciUser = "root", ciPassword = "root", ciDatabase = "mysql"}
  (defs, is) <- query_ conn "SELECT * FROM db"
  print =<< Streams.toList is
