{-# LANGUAGE OverloadedStrings    #-}
{-# LANGUAGE DataKinds            #-}
module MmoaigAPIWebSpecs.RepresentersSpecs.RockPaperScissorsRoundRepresenterSpec (spec) where

import Test.Hspec (Spec, it, describe, pending, parallel)

import MmoaigAPIWeb.Representers.RockPaperScissorsRoundRepresenter ()

spec :: Spec
spec = parallel $
  describe "MmoaigAPIWeb.Representers.RockPaperScissorsRoundRepresenter" $ do
    describe "JSONAPIResponse" $ 
      it "can be converted to JSON" $ pending
