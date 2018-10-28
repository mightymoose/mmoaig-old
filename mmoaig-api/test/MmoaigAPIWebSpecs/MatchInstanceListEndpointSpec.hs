{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}
module MmoaigAPIWebSpecs.MatchInstanceListEndpointSpec (spec) where

import Test.Hspec (Spec, parallel, describe, it)
import Test.Hspec.Wai (with, pending, shouldRespondWith, get, matchHeaders, (<:>))
import Test.Hspec.Wai.JSON (json)
    
import TestUtilities (testApp)

spec :: Spec
spec = parallel $ with testApp $
  describe "MmoaigAPIWeb.MatchInstanceListEndpoint" $ do
    describe "with no page number query parameter" $
      it "has a bunch of tests" pending
    describe "with no page number query parameter" $ do
      it "responds with a 200" $
        get "v1/match-instances" `shouldRespondWith` 200
      it "responds with Content-Type: application/json" $
        get "v1/match-instances" `shouldRespondWith` 200 {matchHeaders = ["Content-Type" <:> "application/json;charset=utf-8"]}
      it "responds with the first page of match instances" $
        get "v1/match-instances" `shouldRespondWith` [json|{
          data: [ { id: 1 , type: "match_instances", attributes: {"matchInstanceToken": "match 1 token"} }
                , { id: 2 , type: "match_instances", attributes: {"matchInstanceToken": "match 2 token"} }
                , { id: 3 , type: "match_instances", attributes: {"matchInstanceToken": "match 3 token"} }
                , { id: 4 , type: "match_instances", attributes: {"matchInstanceToken": "match 4 token"} }
                , { id: 5 , type: "match_instances", attributes: {"matchInstanceToken": "match 5 token"} }
                , { id: 6 , type: "match_instances", attributes: {"matchInstanceToken": "match 6 token"} }
                , { id: 7 , type: "match_instances", attributes: {"matchInstanceToken": "match 7 token"} }
                , { id: 8 , type: "match_instances", attributes: {"matchInstanceToken": "match 8 token"} }
                , { id: 9 , type: "match_instances", attributes: {"matchInstanceToken": "match 9 token"} }
                , { id: 10, type: "match_instances", attributes: {"matchInstanceToken": "match 10 token"} }
                , { id: 11, type: "match_instances", attributes: {"matchInstanceToken": "match 11 token"} }
                , { id: 12, type: "match_instances", attributes: {"matchInstanceToken": "match 12 token"} }
                , { id: 13, type: "match_instances", attributes: {"matchInstanceToken": "match 13 token"} }
                , { id: 14, type: "match_instances", attributes: {"matchInstanceToken": "match 14 token"} }
                , { id: 15, type: "match_instances", attributes: {"matchInstanceToken": "match 15 token"} }
                , { id: 16, type: "match_instances", attributes: {"matchInstanceToken": "match 16 token"} }
                , { id: 17, type: "match_instances", attributes: {"matchInstanceToken": "match 17 token"} }
                , { id: 18, type: "match_instances", attributes: {"matchInstanceToken": "match 18 token"} }
                , { id: 19, type: "match_instances", attributes: {"matchInstanceToken": "match 19 token"} }
                , { id: 20, type: "match_instances", attributes: {"matchInstanceToken": "match 20 token"} }
                , { id: 21, type: "match_instances", attributes: {"matchInstanceToken": "match 21 token"} }
                , { id: 22, type: "match_instances", attributes: {"matchInstanceToken": "match 22 token"} }
                , { id: 23, type: "match_instances", attributes: {"matchInstanceToken": "match 23 token"} }
                , { id: 24, type: "match_instances", attributes: {"matchInstanceToken": "match 24 token"} }
                , { id: 25, type: "match_instances", attributes: {"matchInstanceToken": "match 25 token"} }
                ]
        }|]
      it "includes the total number of match instances in the response" pending
    describe "with a negative page number query parameter" $ do
      it "responds with an error code" pending
      it "responds with Content-Type: application/json" pending
      it "responds with an error description" pending
    describe "with a page number query parameter of 0" $ do
      it "responds with an error code" pending
      it "responds with Content-Type: application/json" pending
      it "responds with an error description" pending
    describe "with a page number query parameter which is too large" $ do
      it "responds with an error code" pending
      it "responds with Content-Type: application/json" pending
      it "responds with an error description" pending
    describe "with a valid page number query parameter" $ do
      it "responds with a 200" pending
      it "responds with Content-Type: application/json" pending
      it "responds with the requested page of match instances" pending
    describe "with no page size query parameter" $ do
      it "responds with a 200" pending
      it "responds with Content-Type: application/json" pending
      it "responds with 25 match instances" pending
      it "includes the total number of match instances in the response" pending
    describe "with a negative page size query parameter" $ do
      it "responds with an error code" pending
      it "responds with Content-Type: application/json" pending
      it "responds with an error description" pending
    describe "with a page size query parameter of 0" $ do
      it "responds with an error code" pending
      it "responds with Content-Type: application/json" pending
      it "responds with an error description" pending
    describe "with a page size query parameter which is too large" $ do
      it "responds with an error code" pending
      it "responds with Content-Type: application/json" pending
      it "responds with an error description" pending
    describe "with a valid page size query parameter" $ do
      it "responds with a 200" pending
      it "responds with Content-Type: application/json" pending
      it "responds with the requested number of match instances" pending
      it "includes the total number of match instances in the response" pending
