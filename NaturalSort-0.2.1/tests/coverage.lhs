#!/usr/bin/env runhaskell

> module Main (main) where
> import Control.Monad (when)
> import System.Cmd
> import System.Directory
> excludeModules = ["Main", "Properties", "Unit"]
> main = do
>     hpcExists <- doesDirectoryExist ".hpc"
>     when hpcExists $ do
>         removeDirectoryRecursive ".hpc"
>         removeFile "test.tix"
>     system "cabal configure -f test -f coverage --disable-optimization"
>     system "cabal build"
>     system "dist/build/test/test >/dev/null"
>     system ("hpc markup test.tix --destdir=coverage " ++ exclude)
>     system ("hpc report test.tix " ++ exclude)
>     where
>         exclude = unwords (map ("--exclude=" ++) excludeModules)
