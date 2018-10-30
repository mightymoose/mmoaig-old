{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}
module MmoaigAPIWebSpecs.BotListEndpointSpec (spec) where

import Test.Hspec (Spec, parallel, describe, it)
import Test.Hspec.Wai (with, pending, shouldRespondWith, get, matchHeaders, (<:>))
import Test.Hspec.Wai.JSON (json)
    
import TestUtilities (testApp)

spec :: Spec
spec = parallel $ with testApp $
  describe "MmoaigAPIWeb.BotListEndpoint" $ do
    describe "with no page number query parameter" $ do
      it "responds with a 200" $
        get "v1/bots" `shouldRespondWith` 200
      it "responds with Content-Type: application/json" $
        get "v1/bots" `shouldRespondWith` 200 {matchHeaders = ["Content-Type" <:> "application/json;charset=utf-8"]}
      it "responds with the first page of bots" $
        get "v1/bots" `shouldRespondWith` [json|{
          data: [ { id: 1 , type: "bots", attributes: {path: "rock-paper-scissors/rock-bot.js", createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00", githubRepositoryId: 1} }
                , { id: 2 , type: "bots", attributes: {path: "rock-paper-scissors/paper-bot.js", createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00", githubRepositoryId: 1} }
                , { id: 3 , type: "bots", attributes: {path: "rock-paper-scissors/scissors-bot.js", createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00", githubRepositoryId: 1} }
                , { id: 4 , type: "bots", attributes: {path: "bot_path #4", createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00", githubRepositoryId: 4} }
                , { id: 5 , type: "bots", attributes: {path: "bot_path #5", createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00", githubRepositoryId: 5} }
                , { id: 6 , type: "bots", attributes: {path: "bot_path #6", createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00", githubRepositoryId: 6} }
                , { id: 7 , type: "bots", attributes: {path: "bot_path #7", createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00", githubRepositoryId: 7} }
                , { id: 8 , type: "bots", attributes: {path: "bot_path #8", createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00", githubRepositoryId: 8} }
                , { id: 9 , type: "bots", attributes: {path: "bot_path #9", createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00", githubRepositoryId: 9} }
                , { id: 10, type: "bots", attributes: {path: "bot_path #10", createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00", githubRepositoryId: 10} }
                , { id: 11, type: "bots", attributes: {path: "bot_path #11", createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00", githubRepositoryId: 11} }
                , { id: 12, type: "bots", attributes: {path: "bot_path #12", createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00", githubRepositoryId: 12} }
                , { id: 13, type: "bots", attributes: {path: "bot_path #13", createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00", githubRepositoryId: 13} }
                , { id: 14, type: "bots", attributes: {path: "bot_path #14", createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00", githubRepositoryId: 14} }
                , { id: 15, type: "bots", attributes: {path: "bot_path #15", createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00", githubRepositoryId: 15} }
                , { id: 16, type: "bots", attributes: {path: "bot_path #16", createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00", githubRepositoryId: 16} }
                , { id: 17, type: "bots", attributes: {path: "bot_path #17", createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00", githubRepositoryId: 17} }
                , { id: 18, type: "bots", attributes: {path: "bot_path #18", createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00", githubRepositoryId: 18} }
                , { id: 19, type: "bots", attributes: {path: "bot_path #19", createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00", githubRepositoryId: 19} }
                , { id: 20, type: "bots", attributes: {path: "bot_path #20", createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00", githubRepositoryId: 20} }
                , { id: 21, type: "bots", attributes: {path: "bot_path #21", createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00", githubRepositoryId: 21} }
                , { id: 22, type: "bots", attributes: {path: "bot_path #22", createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00", githubRepositoryId: 22} }
                , { id: 23, type: "bots", attributes: {path: "bot_path #23", createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00", githubRepositoryId: 23} }
                , { id: 24, type: "bots", attributes: {path: "bot_path #24", createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00", githubRepositoryId: 24} }
                , { id: 25, type: "bots", attributes: {path: "bot_path #25", createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00", githubRepositoryId: 25} }
                ]
        }|]
      it "includes the total number of bots in the response" pending
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
      it "responds with the requested page of bots" pending
    describe "with no page size query parameter" $ do
      it "responds with a 200" pending
      it "responds with Content-Type: application/json" pending
      it "responds with 25 bots" pending
      it "includes the total number of bots in the response" pending
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
      it "responds with the requested number of bots" pending
      it "includes the total number of bots in the response" pending

