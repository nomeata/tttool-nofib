{-# OPTIONS_GHC -fno-warn-missing-signatures #-}

module Unit (main) where

import NaturalSort

import qualified Data.ByteString.Char8 as B

unit1 = (["z10.txt"
         ,"z100.txt"
         ,"z400.txt"
         ,"z72.txt"
         ,"z71.txt"
         ,"z20.txt"
         ,"z1.txt"],
         ["z1.txt"
         ,"z10.txt"
         ,"z20.txt"
         ,"z71.txt"
         ,"z72.txt"
         ,"z100.txt"
         ,"z400.txt"])
unit2 = (["a10.txt"
         ,"a2.txt"
         ,"a1.txt"
         ,"a20.txt"
         ,"a2.txt"
         ,"a700.txt"],
         ["a1.txt"
         ,"a2.txt"
         ,"a2.txt"
         ,"a10.txt"
         ,"a20.txt"
         ,"a700.txt"])
unit3 = (["12 Geese a' Quackin'"
         ,"10 Monkeys a' Writin'"
         ,"1 Fish a' Flappin'"
         ,"And a Dwarf in a Pear Tree-e"],
         ["1 Fish a' Flappin'"
         ,"10 Monkeys a' Writin'"
         ,"12 Geese a' Quackin'"
         ,"And a Dwarf in a Pear Tree-e"])
unit4 = (["1c"
         ,"1a"
         ,"1b"],
         ["1a"
         ,"1b"
         ,"1c"])

test :: ([String], [String]) -> Bool
test (inp, out) = natSort inp' == out'
    where
        inp' = map B.pack inp
        out' = map B.pack out

runTests :: [(String, ([String], [String]))] -> IO ()
runTests = mapM_ (\(n, s) -> putStr (n ++ ": ") >>
                             putStrLn (if test s then "OK" else "FALSE"))

main = runTests [("unit1", unit1)
                ,("unit2", unit2)
                ,("unit3", unit3)
                ,("unit4", unit4)]
