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
          data: [ { id: 1 , type: "matches", attributes: {type: "RockPaperScissors", status: "MatchPending", createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00"} }
                , { id: 2 , type: "matches", attributes: {type: "RockPaperScissors", status: "MatchInProgress", createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00"} }
                , { id: 3 , type: "matches", attributes: {type: "RockPaperScissors", status: "MatchComplete", createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00"} }
                , { id: 4 , type: "matches", attributes: {type: "RockPaperScissors", status: "MatchCancelled", createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00"} }
                , { id: 5 , type: "matches", attributes: {type: "RockPaperScissors", status: "MatchCancelled", createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00"} }
                , { id: 6 , type: "matches", attributes: {type: "RockPaperScissors", status: "MatchCancelled", createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00"} }
                , { id: 7 , type: "matches", attributes: {type: "RockPaperScissors", status: "MatchCancelled", createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00"} }
                , { id: 8 , type: "matches", attributes: {type: "RockPaperScissors", status: "MatchCancelled", createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00"} }
                , { id: 9 , type: "matches", attributes: {type: "RockPaperScissors", status: "MatchCancelled", createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00"} }
                , { id: 10, type: "matches", attributes: {type: "RockPaperScissors", status: "MatchCancelled", createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00"} }
                , { id: 11, type: "matches", attributes: {type: "RockPaperScissors", status: "MatchCancelled", createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00"} }
                , { id: 12, type: "matches", attributes: {type: "RockPaperScissors", status: "MatchCancelled", createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00"} }
                , { id: 13, type: "matches", attributes: {type: "RockPaperScissors", status: "MatchCancelled", createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00"} }
                , { id: 14, type: "matches", attributes: {type: "RockPaperScissors", status: "MatchCancelled", createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00"} }
                , { id: 15, type: "matches", attributes: {type: "RockPaperScissors", status: "MatchCancelled", createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00"} }
                , { id: 16, type: "matches", attributes: {type: "RockPaperScissors", status: "MatchCancelled", createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00"} }
                , { id: 17, type: "matches", attributes: {type: "RockPaperScissors", status: "MatchCancelled", createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00"} }
                , { id: 18, type: "matches", attributes: {type: "RockPaperScissors", status: "MatchCancelled", createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00"} }
                , { id: 19, type: "matches", attributes: {type: "RockPaperScissors", status: "MatchCancelled", createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00"} }
                , { id: 20, type: "matches", attributes: {type: "RockPaperScissors", status: "MatchCancelled", createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00"} }
                , { id: 21, type: "matches", attributes: {type: "RockPaperScissors", status: "MatchCancelled", createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00"} }
                , { id: 22, type: "matches", attributes: {type: "RockPaperScissors", status: "MatchCancelled", createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00"} }
                , { id: 23, type: "matches", attributes: {type: "RockPaperScissors", status: "MatchCancelled", createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00"} }
                , { id: 24, type: "matches", attributes: {type: "RockPaperScissors", status: "MatchCancelled", createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00"} }
                , { id: 25, type: "matches", attributes: {type: "RockPaperScissors", status: "MatchCancelled", createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00"} }
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

