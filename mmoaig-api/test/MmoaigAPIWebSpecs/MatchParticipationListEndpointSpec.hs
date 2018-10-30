{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}
module MmoaigAPIWebSpecs.MatchParticipationListEndpointSpec (spec) where

import Test.Hspec (Spec, parallel, describe, it)
import Test.Hspec.Wai (with, pending, shouldRespondWith, get, matchHeaders, (<:>))
import Test.Hspec.Wai.JSON (json)
    
import TestUtilities (testApp)

spec :: Spec
spec = parallel $ with testApp $
  describe "MmoaigAPIWeb.MatchParticipationListEndpoint" $ do
    describe "with no page number query parameter" $ do
      it "responds with a 200" $
        get "v1/match-participation" `shouldRespondWith` 200
      it "responds with Content-Type: application/json" $
        get "v1/match-participation" `shouldRespondWith` 200 {matchHeaders = ["Content-Type" <:> "application/json;charset=utf-8"]}
      it "responds with the first page of match participation" $
        get "v1/match-participation" `shouldRespondWith` [json|{
          data: [ { id: 1 , type: "match_participation", attributes: {botId: 2, matchId: 1, createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00"} }
                , { id: 2 , type: "match_participation", attributes: {botId: 3, matchId: 1, createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00"} }
                , { id: 3 , type: "match_participation", attributes: {botId: 1, matchId: 2, createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00"} }
                , { id: 4 , type: "match_participation", attributes: {botId: 1, matchId: 2, createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00"} }
                , { id: 5 , type: "match_participation", attributes: {botId: 1, matchId: 3, createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00"} }
                , { id: 6 , type: "match_participation", attributes: {botId: 1, matchId: 3, createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00"} }
                , { id: 7 , type: "match_participation", attributes: {botId: 1, matchId: 4, createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00"} }
                , { id: 8 , type: "match_participation", attributes: {botId: 1, matchId: 4, createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00"} }
                , { id: 9 , type: "match_participation", attributes: {botId: 1, matchId: 5, createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00"} }
                , { id: 10, type: "match_participation", attributes: {botId: 1, matchId: 5, createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00"} }
                , { id: 11, type: "match_participation", attributes: {botId: 1, matchId: 6, createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00"} }
                , { id: 12, type: "match_participation", attributes: {botId: 1, matchId: 6, createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00"} }
                , { id: 13, type: "match_participation", attributes: {botId: 1, matchId: 7, createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00"} }
                , { id: 14, type: "match_participation", attributes: {botId: 1, matchId: 7, createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00"} }
                , { id: 15, type: "match_participation", attributes: {botId: 1, matchId: 8, createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00"} }
                , { id: 16, type: "match_participation", attributes: {botId: 1, matchId: 8, createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00"} }
                , { id: 17, type: "match_participation", attributes: {botId: 1, matchId: 9, createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00"} }
                , { id: 18, type: "match_participation", attributes: {botId: 1, matchId: 9, createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00"} }
                , { id: 19, type: "match_participation", attributes: {botId: 1, matchId: 10, createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00"} }
                , { id: 20, type: "match_participation", attributes: {botId: 1, matchId: 10, createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00"} }
                , { id: 21, type: "match_participation", attributes: {botId: 1, matchId: 11, createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00"} }
                , { id: 22, type: "match_participation", attributes: {botId: 1, matchId: 11, createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00"} }
                , { id: 23, type: "match_participation", attributes: {botId: 1, matchId: 12, createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00"} }
                , { id: 24, type: "match_participation", attributes: {botId: 1, matchId: 12, createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00"} }
                , { id: 25, type: "match_participation", attributes: {botId: 1, matchId: 13, createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00"} }
                ]
        }|]
      it "includes the total number of match participations in the response" pending
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
      it "responds with the requested page of match participations" pending
    describe "with no page size query parameter" $ do
      it "responds with a 200" pending
      it "responds with Content-Type: application/json" pending
      it "responds with 25 match participations" pending
      it "includes the total number of match participations in the response" pending
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
      it "responds with the requested number of match participations" pending
      it "includes the total number of match participations in the response" pending

