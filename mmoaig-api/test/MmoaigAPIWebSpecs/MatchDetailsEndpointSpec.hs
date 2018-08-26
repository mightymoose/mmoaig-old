{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}
module MmoaigAPIWebSpecs.MatchDetailsEndpointSpec (spec) where

import Test.Hspec (Spec, parallel, describe, it)
import Test.Hspec.Wai (with, shouldRespondWith, get, matchHeaders, (<:>))
import Test.Hspec.Wai.JSON (json)
    
import TestUtilities (testApp)

spec :: Spec
spec = parallel $ with testApp $
  describe "MmoaigAPIWeb.MatchDetailsEndpoint" $ do
    describe "with a valid match id" $ do
      it "responds with a 200" $
        get "v1/matches/1" `shouldRespondWith` 200
      it "responds with Content-Type: application/json" $
        get "v1/matches/1" `shouldRespondWith` 200 {matchHeaders = ["Content-Type" <:> "application/json;charset=utf-8"]}
      it "responds with the match details" $
        get "v1/matches/1" `shouldRespondWith` [json|{
          data: { id: 1 , type: "matches", attributes: {type: "RockPaperScissors", status: "MatchPending"}},
          relationships: {
            participants: {
              data: [
                { id: 2 , type: "bots", attributes: {path: "rock-paper-scissors/paper-bot.js"} },
                { id: 3 , type: "bots", attributes: {path: "rock-paper-scissors/scissors-bot.js"} }
              ]
            }
          }
        }|]
