-- |
-- Module      : Main
-- Copyright   : (c) Joachim Fasting 2008-2010
-- License     : BSD3 (see COPYING)
-- Maintainer  : joachim.fasting@gmail.com
-- Stability   : unstable
-- Portability : unportable
--
-- Compilation: ghc -O2 --make Main.hs -o nsort
--
-- Usage: nsort [FILE]...
--
-- Write a sorted concatenation of all FILE(s) to standard output.
--
-- If no files are given, read from standard input.

module Main (main) where

import NaturalSort (natSort)

import Data.ByteString.Char8 (ByteString)
import qualified Data.ByteString.Char8 as B
import System.Console.GetOpt
import System.Environment (getArgs)
import System.Exit

data Flag = Help | Version deriving Eq

options :: [OptDescr Flag]
options = [Option "" ["help"] (NoArg Help) "Show program help"
          ,Option "" ["version"] (NoArg Version) "Show program version"
          ]

usage, version :: String
usage   = usageInfo ("Usage: nsort [OPTION]... [FILE]...\n"
                  ++ "Write sorted concatenation of all FILE(s) to stdout.\n")
                  options
                  ++ "\nWith no FILE read standard input.\n"
version = "nsort 0.2.1"

parseArgv :: [String] -> IO [String]
parseArgv argv =
    case getOpt Permute options argv of
        (flags, args, []) | Help `elem` flags    -> putStr usage >>
                                                    exitWith ExitSuccess
                          | Version `elem` flags -> putStrLn version >>
                                                    exitWith ExitSuccess
                          | otherwise            -> return args
        (_, _, errs) -> fail (head errs)

-- Read input from a list of files, or from standard input.
inp :: [FilePath] -> IO ByteString
inp [] = B.getContents
inp xs = B.concat `fmap` mapM B.readFile xs

-- | Main.
main :: IO ()
main = getArgs >>= parseArgv >>= inp >>= B.putStr . B.unlines . natSort
     . B.lines
