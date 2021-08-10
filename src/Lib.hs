module Lib
    (getRecursiveDirectoryContents
    ) where
import Control.Monad (forM)
import System.Directory (doesDirectoryExist, getDirectoryContents, getCurrentDirectory)
import System.FilePath ((</>))
import Data.List.Utils (replace)
getRecursiveDirectoryContents :: FilePath -> IO [FilePath]
getRecursiveDirectoryContents topDir = do
  names <- getDirectoryContents topDir
  let properNames = filter (`notElem` [".", ".."]) names
  paths <- forM properNames $ \name -> do
    let path = topDir </> name
    isDirectory <- doesDirectoryExist path
    tmpDir <- getCurrentDirectory
    let curDir = tmpDir ++ "/"
    if isDirectory
    then getRecursiveDirectoryContents path
    else return [replace "./" curDir path]
  return (concat paths)
