-- |
-- Module      : Chunk
-- Copyright   : (c) Joachim Fasting 2008-2010
-- License     : BSD3 (see COPYING)
-- Maintainer  : joachim.fasting@gmail.com
-- Stability   : unstable
-- Portability : unportable
--
-- Break textual input into sortable chunks.

module Chunk (Chunk, toChunks) where

import Data.ByteString.Char8 (ByteString)
import qualified Data.ByteString.Char8 as B
import Data.Char (isDigit)
import Data.Function (on)
import Data.Maybe (fromJust)

import Prelude hiding (Either(..))
import Data.Strict.Either

-- | A chunk is either a pure integral value, or a string that might contain
-- digits, letters and other characters.
--
-- When preparing strings for natural comparison, they are first broken into
-- several chunks, which can then be compared and ordered \"naturally\".
type Chunk = Either Int ByteString

-- Returns 'True' if both inputs have the same \"digitness\", that is, both
-- are digits or non-digits.
digitness :: Char -> Char -> Bool
digitness = (==) `on` isDigit

-- Convert a string to a single 'Chunk'.
--
-- Note that leading 0s are not preserved.
-- As a consequence, this operation is _not_ reversible.
--
-- > convert "12" = Left 12
-- > convert "ab" = Right "ab"
-- > convert "a1" = Right "a1"
-- > convert "01" = Left 1
convert :: ByteString -> Chunk
convert x = (if B.all isDigit x then Left . parse else Right) x
    where
        parse = fst . fromJust . B.readInt

-- | Turn a string into a list of 'Chunk's.
--
-- > toChunks "a12x.txt" = [S "a", N 12, S "x.txt"]
-- > toChunks "7" `compare` toChunks "10" = LT
-- > toChunks "a7.txt" `compare` toChunks "a10.txt" = LT
-- > toChunks "7a.txt" `compare` toChunks "10a.txt" = LT
toChunks :: ByteString -> [Chunk]
toChunks = map convert . B.groupBy digitness
