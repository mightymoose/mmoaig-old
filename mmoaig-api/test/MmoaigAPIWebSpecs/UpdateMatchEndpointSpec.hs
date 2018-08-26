{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}
module MmoaigAPIWebSpecs.UpdateMatchEndpointSpec (spec) where

import Test.Hspec (Spec, context, it, describe, parallel)
import Test.Hspec.Wai (with, pending)
    
import TestUtilities (testApp)

spec :: Spec
spec = parallel $ with testApp $
  describe "MmoaigAPIWeb.MatchDetailsEndpoint" $ do
    context "with a valid match id and status" $ do
      it "responds with a 200" pending
      it "responds with content-type: application/json" pending
      it "responds with the updated attributes" pending
    context "with a valid match id and an invalid status" $ do
      it "responds with a 422" pending
      it "responds with content-type: application/json" pending
      it "responds with the new match attributes" pending
    context "with a valid match id and no status" $ do
      it "responds with a 422" pending
      it "responds with content-type: application/json" pending
      it "responds with the new match attributes" pending
    context "with an invalid match id and an invalid status" $ do
      it "responds with a 422" pending
      it "responds with content-type: application/json" pending
      it "responds with the new match attributes" pending
