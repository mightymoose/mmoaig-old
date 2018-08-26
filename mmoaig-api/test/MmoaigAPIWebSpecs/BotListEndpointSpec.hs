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
          data: [ { id: 1 , type: "bots", attributes: {path: "rock-paper-scissors/rock-bot.js"} }
                , { id: 2 , type: "bots", attributes: {path: "rock-paper-scissors/paper-bot.js"} }
                , { id: 3 , type: "bots", attributes: {path: "rock-paper-scissors/scissors-bot.js"} }
                , { id: 4 , type: "bots", attributes: {path: "bot_path #4"} }
                , { id: 5 , type: "bots", attributes: {path: "bot_path #5"} }
                , { id: 6 , type: "bots", attributes: {path: "bot_path #6"} }
                , { id: 7 , type: "bots", attributes: {path: "bot_path #7"} }
                , { id: 8 , type: "bots", attributes: {path: "bot_path #8"} }
                , { id: 9 , type: "bots", attributes: {path: "bot_path #9"} }
                , { id: 10, type: "bots", attributes: {path: "bot_path #10"} }
                , { id: 11, type: "bots", attributes: {path: "bot_path #11"} }
                , { id: 12, type: "bots", attributes: {path: "bot_path #12"} }
                , { id: 13, type: "bots", attributes: {path: "bot_path #13"} }
                , { id: 14, type: "bots", attributes: {path: "bot_path #14"} }
                , { id: 15, type: "bots", attributes: {path: "bot_path #15"} }
                , { id: 16, type: "bots", attributes: {path: "bot_path #16"} }
                , { id: 17, type: "bots", attributes: {path: "bot_path #17"} }
                , { id: 18, type: "bots", attributes: {path: "bot_path #18"} }
                , { id: 19, type: "bots", attributes: {path: "bot_path #19"} }
                , { id: 20, type: "bots", attributes: {path: "bot_path #20"} }
                , { id: 21, type: "bots", attributes: {path: "bot_path #21"} }
                , { id: 22, type: "bots", attributes: {path: "bot_path #22"} }
                , { id: 23, type: "bots", attributes: {path: "bot_path #23"} }
                , { id: 24, type: "bots", attributes: {path: "bot_path #24"} }
                , { id: 25, type: "bots", attributes: {path: "bot_path #25"} }
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

