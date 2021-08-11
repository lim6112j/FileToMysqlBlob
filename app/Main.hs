module Main where
import Lib
import Mysql
import Database.MySQL.Base as DMB
import qualified Data.ByteString as B
import Data.Text.Internal
import Control.Monad.Writer (Writer,writer, tell, runWriter)
logPath :: IO ([(String, B.ByteString)]) -> Writer [String] (IO ([(String,B.ByteString)]))
logPath x = writer (x, ["value of readPath"])
readPath :: [(String, String)] -> Writer [String] (IO ([(String,B.ByteString)]))
readPath params = do
  out <- logPath (mapM f params)
  tell ["hello"]
  return out
  where f (x,y) = do
          byteStr <- B.readFile (x ++ "/" ++ y)
          return (x, byteStr)
main :: IO ()
main = do
  putStrLn "type filepath you want"
  path <- getLine
  paths <- getRecursiveDirectoryContents path
  putStrLn $ "Items to be commited to Database : " ++ show (length paths)
  putStrLn $ show $ snd $ runWriter $ readPath paths
  byteStrs <- fst $ runWriter $ readPath paths
  oks <- insertData byteStrs
  putStrLn oks
