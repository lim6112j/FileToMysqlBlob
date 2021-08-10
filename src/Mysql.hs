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
insertData (paths::[B.ByteString]) = do
  conn <- connect
    defaultConnectInfo {ciHost="133.186.212.161", ciPort=3306, ciUser = "root", ciPassword = "thecheat99))", ciDatabase = "thecheat_api"}
  let params = map (\x -> [MySQLBytes x]) paths
  print $ length params
  oks <- withTransaction conn $ executeMany conn "INSERT INTO uploaded_images(imageData) VALUES(?)" params
  return (show oks)
