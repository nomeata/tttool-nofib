-- |
-- Module      : NaturalSort
-- Copyright   : (c) Joachim Fasting 2008-2010
-- License     : BSD3 (see COPYING)
-- Maintainer  : joachim.fasting@gmail.com
-- Stability   : unstable
-- Portability : unportable
--
-- Natural sorting for strings.

module NaturalSort (natSort, natSortS) where

import Chunk

import Data.ByteString.Char8 (ByteString)
import qualified Data.ByteString.Char8 as B
import Data.List (sortBy)
import Data.Ord (comparing)

-- @sortWith f xs@ is equal to @sortBy (comparing f) xs@, except @f@
-- is applied only once for each element of @xs@.
-- In principle, this is equal to @sort . map f@, but preserves input
-- elements.
sortWith :: Ord b => (a -> b) -> [a] -> [a]
sortWith cmp xs = map snd $ sortBy (comparing fst) (zip (map cmp xs) xs)

-- | Sort a list of 'ByteString's using natural comparison.
natSort :: [ByteString] -> [ByteString]
natSort = sortWith toChunks

-- | Sort a list of 'String's using natural comparison
-- (converts to and from 'ByteString')
natSortS :: [String] -> [String]
natSortS = map B.unpack . natSort . map B.pack
