{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# OPTIONS_GHC -XDataKinds#-}
module Mysql(getDBInfo, insertData) where
import Database.MySQL.Base
import qualified System.IO.Streams as Streams
import qualified Data.ByteString as B
import qualified Data.Text as T
queryLimit = 1
executeMulti :: MySQLConn -> [[MySQLValue]] -> [[IO OK]]
executeMulti conn params
    | null params = []
    | length params < queryLimit = [executeSmall params]
    | otherwise         = executeSmall (take queryLimit params):executeMulti conn (drop queryLimit params)
    where
      executeSmall = map (execute conn "INSERT INTO uploaded_images(imagepath, imagedata) VALUES(?, ?)")

getDBInfo :: IO()
getDBInfo = do
  conn <- connect
    defaultConnectInfo {ciHost="133.186.212.161", ciPort=3306, ciUser = "root", ciPassword = "thecheat99))", ciDatabase = "thecheat_api"}
  (defs, is) <- query_ conn "SELECT * FROM uploaded_images limit 1"
  print =<< Streams.toList is
insertData :: [(String, B.ByteString)] -> IO String
insertData paths = do
  conn <- connect
    defaultConnectInfo {ciHost="133.186.212.161", ciPort=3306, ciUser = "root", ciPassword = "thecheat99))", ciDatabase = "thecheat_api"}
  let params = map (\(x, y) -> [MySQLText (T.pack x), MySQLBytes y]) paths
  print $ length params
  oks <- sequence $ concat $ executeMulti conn params
  --oks <- withTransaction conn $ executeMany conn "INSERT INTO uploaded_images(imageData) VALUES(?)" params
  return (show oks)
