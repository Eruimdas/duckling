-- Copyright (c) 2016-present, Facebook, Inc.
-- All rights reserved.
--
-- This source code is licensed under the BSD-style license found in the
-- LICENSE file in the root directory of this source tree.


{-# LANGUAGE OverloadedStrings #-}

module Duckling.Quantity.TR.Corpus
  ( corpus
  , latentCorpus
  ) where

import Prelude
import Data.String

import Duckling.Quantity.Types
import Duckling.Resolve (Options(..))
import Duckling.Testing.Types

corpus :: Corpus
corpus = (testContext, testOptions, allExamples)


latentCorpus :: Corpus
latentCorpus = (testContext, testOptions {withLatent = True}, latentExamples)
  where
    latentExamples = concat
      [
      examples (simple Unnamed 4 Nothing)
                [ "4 civarında"
                , "dört"
                , "~ dört"
                ]
      ,
      examples (simple Unnamed 38.5 Nothing)
                [ "38.5 gibi"
                ]
      ]

allExamples :: [Example]
allExamples = concat
  [ examples (simple Pound 2 (Just "et"))
             [ "iki libre et"
             ]
  , examples (simple Gram 2 Nothing)
             [ "2 gram"
             , "0.002 kg"
             , "2 g."
             , "2/1000 kilogram"
             , "2000 miligram"
             , "2,000 miligram"
             ]
  , examples (simple Gram 1000 Nothing)
             [ "kilogram"
             , "kg"
             , "1 k.g."
             ]
  , examples (simple Pound 1 Nothing)
             [ "Libre"
             , "1 lb"
             , "lb"
             ]
  , examples (simple Ounce 2 Nothing)
             [ "2 ons"
             , "2oz"
             ]
  , examples (simple Cup 3 (Just "şeker"))
             [ "3 bardak şeker"
             , "3 bardak Şeker"
             ]
  , examples (simple Cup 0.75 Nothing)
             [ "3/4 bardak"
             , "0.75 bardak"
             , ".75 bardak"
             ]
  , examples (simple Gram 500 (Just "çilek"))
             [ "500 gram çilek"
             , "500g çilek"
             , "0.5 kilogram çilek"
             , "0.5 kg çilek"
             , "500000mg çilek"
             ]
  , examples (between Gram (100,1000) (Just "çilek"))
              [ "100-1000 gram çilek"
              , "100 ila 1000 gram arasında çilek"
              , "100 ila 1000 g çilek"
              , "100 - 1000 g çilek"
              ]
  , examples (between Gram (2,7) Nothing)
              [ "2 -7 g civarında"
              , "~2-7 gram"
              , "2 ila 7 g"
              , "2.0 g ile yaklaşık 7.0 g arasında"
              , "0.002 kg ile yaklaşık 0.007 kg arasında"
              , "2 - ~7 gram"
              ]
  , examples (under Pound 6 (Just "et"))
              [ "6 libreden az et"
              , "en fazla 6 lbs et"
              , "6.0 libreden az et"
              , "en fazla 6 libre et"
              ]
  , examples (above Cup 2 Nothing)
              [ "2 bardaktan fazla"
              , "en az 2 bardak"
              , "2'den fazla bardak"
              ]
  , examples (above Ounce 4 (Just "çikolata"))
              [ "4 ozdan fazla çikolata"
              , "en az 4.0 oz çikolata"
              , "dört onstan fazla çikolata"
              ]
  ]
