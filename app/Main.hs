module Main where
import Lib
import Mysql
import Database.MySQL.Base as DMB
import qualified Data.ByteString as B
import Data.Text.Internal
readPath :: [(String, String)] -> IO ([(String,B.ByteString)])
readPath = mapM f
  where f (x,y) = do
          byteStr <- B.readFile (x ++ "/" ++ y)
          return (x, byteStr)
main :: IO ()
main = do
  putStrLn "type filepath you want"
  path <- getLine
  paths <- getRecursiveDirectoryContents path
  putStrLn $ "Items to be commited to Database : " ++ show (length paths)
  byteStrs <- readPath paths
  oks <- insertData byteStrs
  putStrLn oks
