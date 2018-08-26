{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}
module MmoaigAPIWebSpecs.MatchListEndpointSpec (spec) where

import Test.Hspec (Spec, parallel, describe, it)
import Test.Hspec.Wai (with, pending, shouldRespondWith, get, matchHeaders, (<:>))
import Test.Hspec.Wai.JSON (json)
    
import TestUtilities (testApp)

spec :: Spec
spec = parallel $ with testApp $
  describe "MmoaigAPIWeb.MatchListEndpoint" $ do
    describe "with no page number query parameter" $ do
      it "responds with a 200" $
        get "v1/matches" `shouldRespondWith` 200
      it "responds with Content-Type: application/json" $
        get "v1/matches" `shouldRespondWith` 200 {matchHeaders = ["Content-Type" <:> "application/json;charset=utf-8"]}
      it "responds with the first page of matches" $
        get "v1/matches" `shouldRespondWith` [json|{
          data: [ { id: 1 , type: "matches", attributes: {type: "RockPaperScissors", status: "MatchPending"} }
                , { id: 2 , type: "matches", attributes: {type: "RockPaperScissors", status: "MatchInProgress"} }
                , { id: 3 , type: "matches", attributes: {type: "RockPaperScissors", status: "MatchComplete"} }
                , { id: 4 , type: "matches", attributes: {type: "RockPaperScissors", status: "MatchCancelled"} }
                , { id: 5 , type: "matches", attributes: {type: "RockPaperScissors", status: "MatchCancelled"} }
                , { id: 6 , type: "matches", attributes: {type: "RockPaperScissors", status: "MatchCancelled"} }
                , { id: 7 , type: "matches", attributes: {type: "RockPaperScissors", status: "MatchCancelled"} }
                , { id: 8 , type: "matches", attributes: {type: "RockPaperScissors", status: "MatchCancelled"} }
                , { id: 9 , type: "matches", attributes: {type: "RockPaperScissors", status: "MatchCancelled"} }
                , { id: 10, type: "matches", attributes: {type: "RockPaperScissors", status: "MatchCancelled"} }
                , { id: 11, type: "matches", attributes: {type: "RockPaperScissors", status: "MatchCancelled"} }
                , { id: 12, type: "matches", attributes: {type: "RockPaperScissors", status: "MatchCancelled"} }
                , { id: 13, type: "matches", attributes: {type: "RockPaperScissors", status: "MatchCancelled"} }
                , { id: 14, type: "matches", attributes: {type: "RockPaperScissors", status: "MatchCancelled"} }
                , { id: 15, type: "matches", attributes: {type: "RockPaperScissors", status: "MatchCancelled"} }
                , { id: 16, type: "matches", attributes: {type: "RockPaperScissors", status: "MatchCancelled"} }
                , { id: 17, type: "matches", attributes: {type: "RockPaperScissors", status: "MatchCancelled"} }
                , { id: 18, type: "matches", attributes: {type: "RockPaperScissors", status: "MatchCancelled"} }
                , { id: 19, type: "matches", attributes: {type: "RockPaperScissors", status: "MatchCancelled"} }
                , { id: 20, type: "matches", attributes: {type: "RockPaperScissors", status: "MatchCancelled"} }
                , { id: 21, type: "matches", attributes: {type: "RockPaperScissors", status: "MatchCancelled"} }
                , { id: 22, type: "matches", attributes: {type: "RockPaperScissors", status: "MatchCancelled"} }
                , { id: 23, type: "matches", attributes: {type: "RockPaperScissors", status: "MatchCancelled"} }
                , { id: 24, type: "matches", attributes: {type: "RockPaperScissors", status: "MatchCancelled"} }
                , { id: 25, type: "matches", attributes: {type: "RockPaperScissors", status: "MatchCancelled"} }
                ]
        }|]
      it "includes the total number of matches in the response" pending
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
      it "responds with the requested page of matches" pending
    describe "with no page size query parameter" $ do
      it "responds with a 200" pending
      it "responds with Content-Type: application/json" pending
      it "responds with 25 matches" pending
      it "includes the total number of matches in the response" pending
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
      it "responds with the requested number of matches" pending
      it "includes the total number of matches in the response" pending

