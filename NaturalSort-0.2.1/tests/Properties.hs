{-# OPTIONS_GHC -fno-warn-missing-signatures -fno-warn-missing-methods
                -fno-warn-orphans #-}

module Properties (main) where

import Chunk
import NaturalSort

import Data.ByteString.Char8 (ByteString)
import qualified Data.ByteString.Char8 as B
import Data.List
import Data.Ord
import Test.QuickCheck
import Text.Printf

instance Arbitrary ByteString where
    arbitrary = B.pack `fmap` arbitrary

-- Verify that natSort preserves input elements
prop_natSort_integ xs = sort (natSort xs) == sort xs

-- Verify that natSort is idempotent
prop_natSort_idem xs = natSort xs == natSort (natSort xs)

-- Verify that natSort conforms to a model
prop_natSort_model xs = natSort xs == model xs
    where
        model = sortBy (comparing toChunks)

-- Verify that natSortS yields the same result as natSort
prop_natSortS xs = map B.pack (natSortS xs') == natSort xs
    where
        xs' = map B.unpack xs

mytest :: Testable a => a -> Int -> IO ()
mytest f n = quickCheckWith stdArgs { maxSize = n } f

main = mapM_ (\(s, f) -> printf "%-20s: " s >> f ntest) tests
    where
        tests = [("natSort / integrity", mytest prop_natSort_integ)
                ,("natSort / idempotent", mytest prop_natSort_idem)
                ,("natSort / model", mytest prop_natSort_model)
                ,("natSortS", mytest prop_natSortS)]
        ntest = 100
