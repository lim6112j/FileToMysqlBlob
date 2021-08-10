{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ScopedTypeVariables #-}
module Mysql(getDBInfo, insertData) where
import Database.MySQL.Base
import qualified System.IO.Streams as Streams
getDBInfo :: IO()
getDBInfo = do
  conn <- connect
    defaultConnectInfo {ciHost="133.186.212.161", ciPort=3306, ciUser = "root", ciPassword = "thecheat99))", ciDatabase = "thecheat_api"}
  (defs, is) <- query_ conn "SELECT * FROM uploaded_images limit 1"
  print =<< Streams.toList is
insertData (qry::Query) = do
  conn <- connect
    defaultConnectInfo {ciHost="133.186.212.161", ciPort=3306, ciUser = "root", ciPassword = "thecheat99))", ciDatabase = "thecheat_api"}
  withTransaction conn $ executeMany_ conn qry
