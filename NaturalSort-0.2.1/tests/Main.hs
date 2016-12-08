module Main (main) where

import qualified Properties
import qualified Unit

main :: IO ()
main = Unit.main >> Properties.main
