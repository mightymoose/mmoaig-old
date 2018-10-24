{-# LANGUAGE OverloadedStrings    #-}
{-# LANGUAGE DataKinds            #-}
module MmoaigAPIWebSpecs.RepresentersSpecs.MatchInstanceRepresenterSpec (spec) where

import Test.Hspec (Spec, it, describe, pending, parallel)

import MmoaigAPIWeb.Representers.MatchInstanceRepresenter ()

spec :: Spec
spec = parallel $
  describe "MmoaigAPIWeb.Representers.UserRepresenter" $ do
    describe "JSONAPIResponse" $ 
      it "can be converted to JSON" $ pending
