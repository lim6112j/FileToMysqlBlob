module Lib
    (getRecursiveContents, someFunc
    ) where
import Control.Monad (forM, join)
import System.Directory (doesDirectoryExist, getDirectoryContents, getCurrentDirectory)
import System.FilePath ((</>))
import Data.List.Utils (replace)
getRecursiveContents :: FilePath -> IO [FilePath]
getRecursiveContents topDir = do
  names <- getDirectoryContents topDir
  let properNames = filter (`notElem` [".", ".."]) names
  paths <- forM properNames $ \name -> do
    let path = topDir </> name
    isDirectory <- doesDirectoryExist path
    curDir <- getCurrentDirectory
    if isDirectory
    then getRecursiveContents path
    else return [replace "./" curDir path]
  return (concat paths)

someFunc :: IO ()
someFunc = putStrLn "someFunc"
