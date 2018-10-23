{-# LANGUAGE OverloadedStrings    #-}
{-# LANGUAGE DataKinds            #-}
module MmoaigAPIWebSpecs.RepresentersSpecs.UserRepresenterSpec (spec) where

import Test.Hspec (Spec, it, describe, pending, parallel)

import MmoaigAPIWeb.Representers.UserRepresenter ()

spec :: Spec
spec = parallel $
  describe "MmoaigAPIWeb.Representers.UserRepresenter" $ do
    describe "JSONAPIResponse" $ 
      it "can be converted to JSON" $ pending