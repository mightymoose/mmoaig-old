{-# LANGUAGE OverloadedStrings #-}
module MmoaigAPIWebSpecs.BotSourceEndpointSpec (spec)  where

import Test.Hspec (Spec, parallel, describe, it)
import Test.Hspec.Wai (with, matchHeaders, get, shouldRespondWith, (<:>))
    
import TestUtilities (testApp)

spec :: Spec
spec = parallel $ with testApp $
  describe "MmoaigAPIWeb.BotSourceEndpoint" $ do
    let botRequest = get "v1/bots/1/source"
    it "responds with a 200" $
      botRequest `shouldRespondWith` 200
    it "responds with Content-Type: application/json" $
      botRequest `shouldRespondWith` 200 {matchHeaders = ["Content-Type" <:> "application/javascript;charset=utf-8"]}
    it "responds with the bot source" $
      botRequest `shouldRespondWith` "function takeTurn(round) {\n    round.chooseRock();\n}\n"
