{-# LANGUAGE OverloadedStrings    #-}
{-# LANGUAGE DataKinds            #-}
module MmoaigAPIWebSpecs.RepresentersSpecs.MatchParticipationRepresenterSpec (spec) where

import Test.Hspec (Spec, it, describe, pending, parallel)

import MmoaigAPIWeb.Representers.MatchParticipationRepresenter ()

spec :: Spec
spec = parallel $
  describe "MmoaigAPIWeb.Representers.MatchParticipationRepresenter" $ do
    describe "JSONAPIResponse" $ 
      it "can be converted to JSON" $ pending
