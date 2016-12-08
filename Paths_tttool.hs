{-# LANGUAGE CPP #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -fno-warn-implicit-prelude #-}
module Paths_tttool (
    version,
    getBinDir, getLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [1,7] []
bindir, libdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/home/jojo/.cabal/bin"
libdir     = "/home/jojo/.cabal/lib/x86_64-linux-ghc-7.10.3/tttool-1.7"
datadir    = "/home/jojo/.cabal/share/x86_64-linux-ghc-7.10.3/tttool-1.7"
libexecdir = "/home/jojo/.cabal/libexec"
sysconfdir = "/home/jojo/.cabal/etc"

getBinDir, getLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "tttool_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "tttool_libdir") (\_ -> return libdir)
getDataDir = catchIO (getEnv "tttool_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "tttool_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "tttool_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
