{-# LANGUAGE OverloadedStrings    #-}
{-# LANGUAGE DataKinds            #-}
module MmoaigAPIWebSpecs.RepresentersSpecs.BotRepresenterSpec (spec) where

import Test.Hspec (Spec, it, describe, pending, parallel)

import MmoaigAPIWeb.Representers.BotRepresenter ()

spec :: Spec
spec = parallel $
  describe "MmoaigAPIWeb.Representers.BotRepresenter" $ do
    describe "JSONAPIResponse" $ 
      it "can be converted to JSON" $ pending
