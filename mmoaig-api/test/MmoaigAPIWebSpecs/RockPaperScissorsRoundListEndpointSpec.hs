{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}
module MmoaigAPIWebSpecs.RockPaperScissorsRoundListEndpointSpec (spec) where

import Test.Hspec (Spec, parallel, describe, it)
import Test.Hspec.Wai (with, pending, shouldRespondWith, get, matchHeaders, (<:>))
import Test.Hspec.Wai.JSON (json)
    
import TestUtilities (testApp)

spec :: Spec
spec = parallel $ with testApp $
  describe "MmoaigAPIWeb.RockPaperScissorsRoundListEndpoint" $ do
    describe "with no page number query parameter" $ do
      it "responds with a 200" $
        get "v1/rock-paper-scissors-rounds" `shouldRespondWith` 200
      it "responds with Content-Type: application/json" $
        get "v1/rock-paper-scissors-rounds" `shouldRespondWith` 200 {matchHeaders = ["Content-Type" <:> "application/json;charset=utf-8"]}
      it "responds with the first page of rock paper scissors rounds" $
        get "v1/rock-paper-scissors-rounds" `shouldRespondWith` [json|{
          data: [ { id: 1 , type: "rock_paper_scissors_rounds", attributes: { createdAt: "1707-04-15T00:00:00", firstPlayerThrow: "RockPaperScissorsRock", matchInstanceId: 1, secondPlayerThrow: "RockPaperScissorsRock", updatedAt: "1707-04-15T00:00:00", roundWinnerId: 1, roundNumber: 1 } }
                , { id: 2 , type: "rock_paper_scissors_rounds", attributes: { createdAt: "1707-04-15T00:00:00", firstPlayerThrow: "RockPaperScissorsRock", matchInstanceId: 2, secondPlayerThrow: "RockPaperScissorsRock", updatedAt: "1707-04-15T00:00:00", roundWinnerId: 1, roundNumber: 1 } }
                , { id: 3 , type: "rock_paper_scissors_rounds", attributes: { createdAt: "1707-04-15T00:00:00", firstPlayerThrow: "RockPaperScissorsRock", matchInstanceId: 3, secondPlayerThrow: "RockPaperScissorsRock", updatedAt: "1707-04-15T00:00:00", roundWinnerId: 1, roundNumber: 1 } }
                , { id: 4 , type: "rock_paper_scissors_rounds", attributes: { createdAt: "1707-04-15T00:00:00", firstPlayerThrow: "RockPaperScissorsRock", matchInstanceId: 4, secondPlayerThrow: "RockPaperScissorsRock", updatedAt: "1707-04-15T00:00:00", roundWinnerId: 1, roundNumber: 1 } }
                , { id: 5 , type: "rock_paper_scissors_rounds", attributes: { createdAt: "1707-04-15T00:00:00", firstPlayerThrow: "RockPaperScissorsRock", matchInstanceId: 5, secondPlayerThrow: "RockPaperScissorsRock", updatedAt: "1707-04-15T00:00:00", roundWinnerId: 1, roundNumber: 1 } }
                , { id: 6 , type: "rock_paper_scissors_rounds", attributes: { createdAt: "1707-04-15T00:00:00", firstPlayerThrow: "RockPaperScissorsRock", matchInstanceId: 6, secondPlayerThrow: "RockPaperScissorsRock", updatedAt: "1707-04-15T00:00:00", roundWinnerId: 1, roundNumber: 1 } }
                , { id: 7 , type: "rock_paper_scissors_rounds", attributes: { createdAt: "1707-04-15T00:00:00", firstPlayerThrow: "RockPaperScissorsRock", matchInstanceId: 7, secondPlayerThrow: "RockPaperScissorsRock", updatedAt: "1707-04-15T00:00:00", roundWinnerId: 1, roundNumber: 1 } }
                , { id: 8 , type: "rock_paper_scissors_rounds", attributes: { createdAt: "1707-04-15T00:00:00", firstPlayerThrow: "RockPaperScissorsRock", matchInstanceId: 8, secondPlayerThrow: "RockPaperScissorsRock", updatedAt: "1707-04-15T00:00:00", roundWinnerId: 1, roundNumber: 1 } }
                , { id: 9 , type: "rock_paper_scissors_rounds", attributes: { createdAt: "1707-04-15T00:00:00", firstPlayerThrow: "RockPaperScissorsRock", matchInstanceId: 9, secondPlayerThrow: "RockPaperScissorsRock", updatedAt: "1707-04-15T00:00:00", roundWinnerId: 1, roundNumber: 1 } }
                , { id: 10, type: "rock_paper_scissors_rounds", attributes: { createdAt: "1707-04-15T00:00:00", firstPlayerThrow: "RockPaperScissorsRock", matchInstanceId: 10, secondPlayerThrow: "RockPaperScissorsRock", updatedAt: "1707-04-15T00:00:00", roundWinnerId: 1, roundNumber: 1 } }
                , { id: 11, type: "rock_paper_scissors_rounds", attributes: { createdAt: "1707-04-15T00:00:00", firstPlayerThrow: "RockPaperScissorsRock", matchInstanceId: 11, secondPlayerThrow: "RockPaperScissorsRock", updatedAt: "1707-04-15T00:00:00", roundWinnerId: 1, roundNumber: 1 } }
                , { id: 12, type: "rock_paper_scissors_rounds", attributes: { createdAt: "1707-04-15T00:00:00", firstPlayerThrow: "RockPaperScissorsRock", matchInstanceId: 12, secondPlayerThrow: "RockPaperScissorsRock", updatedAt: "1707-04-15T00:00:00", roundWinnerId: 1, roundNumber: 1 } }
                , { id: 13, type: "rock_paper_scissors_rounds", attributes: { createdAt: "1707-04-15T00:00:00", firstPlayerThrow: "RockPaperScissorsRock", matchInstanceId: 13, secondPlayerThrow: "RockPaperScissorsRock", updatedAt: "1707-04-15T00:00:00", roundWinnerId: 1, roundNumber: 1 } }
                , { id: 14, type: "rock_paper_scissors_rounds", attributes: { createdAt: "1707-04-15T00:00:00", firstPlayerThrow: "RockPaperScissorsRock", matchInstanceId: 14, secondPlayerThrow: "RockPaperScissorsRock", updatedAt: "1707-04-15T00:00:00", roundWinnerId: 1, roundNumber: 1 } }
                , { id: 15, type: "rock_paper_scissors_rounds", attributes: { createdAt: "1707-04-15T00:00:00", firstPlayerThrow: "RockPaperScissorsRock", matchInstanceId: 15, secondPlayerThrow: "RockPaperScissorsRock", updatedAt: "1707-04-15T00:00:00", roundWinnerId: 1, roundNumber: 1 } }
                , { id: 16, type: "rock_paper_scissors_rounds", attributes: { createdAt: "1707-04-15T00:00:00", firstPlayerThrow: "RockPaperScissorsRock", matchInstanceId: 16, secondPlayerThrow: "RockPaperScissorsRock", updatedAt: "1707-04-15T00:00:00", roundWinnerId: 1, roundNumber: 1 } }
                , { id: 17, type: "rock_paper_scissors_rounds", attributes: { createdAt: "1707-04-15T00:00:00", firstPlayerThrow: "RockPaperScissorsRock", matchInstanceId: 17, secondPlayerThrow: "RockPaperScissorsRock", updatedAt: "1707-04-15T00:00:00", roundWinnerId: 1, roundNumber: 1 } }
                , { id: 18, type: "rock_paper_scissors_rounds", attributes: { createdAt: "1707-04-15T00:00:00", firstPlayerThrow: "RockPaperScissorsRock", matchInstanceId: 18, secondPlayerThrow: "RockPaperScissorsRock", updatedAt: "1707-04-15T00:00:00", roundWinnerId: 1, roundNumber: 1 } }
                , { id: 19, type: "rock_paper_scissors_rounds", attributes: { createdAt: "1707-04-15T00:00:00", firstPlayerThrow: "RockPaperScissorsRock", matchInstanceId: 19, secondPlayerThrow: "RockPaperScissorsRock", updatedAt: "1707-04-15T00:00:00", roundWinnerId: 1, roundNumber: 1 } }
                , { id: 20, type: "rock_paper_scissors_rounds", attributes: { createdAt: "1707-04-15T00:00:00", firstPlayerThrow: "RockPaperScissorsRock", matchInstanceId: 20, secondPlayerThrow: "RockPaperScissorsRock", updatedAt: "1707-04-15T00:00:00", roundWinnerId: 1, roundNumber: 1 } }
                , { id: 21, type: "rock_paper_scissors_rounds", attributes: { createdAt: "1707-04-15T00:00:00", firstPlayerThrow: "RockPaperScissorsRock", matchInstanceId: 21, secondPlayerThrow: "RockPaperScissorsRock", updatedAt: "1707-04-15T00:00:00", roundWinnerId: 1, roundNumber: 1 } }
                , { id: 22, type: "rock_paper_scissors_rounds", attributes: { createdAt: "1707-04-15T00:00:00", firstPlayerThrow: "RockPaperScissorsRock", matchInstanceId: 22, secondPlayerThrow: "RockPaperScissorsRock", updatedAt: "1707-04-15T00:00:00", roundWinnerId: 1, roundNumber: 1 } }
                , { id: 23, type: "rock_paper_scissors_rounds", attributes: { createdAt: "1707-04-15T00:00:00", firstPlayerThrow: "RockPaperScissorsRock", matchInstanceId: 23, secondPlayerThrow: "RockPaperScissorsRock", updatedAt: "1707-04-15T00:00:00", roundWinnerId: 1, roundNumber: 1 } }
                , { id: 24, type: "rock_paper_scissors_rounds", attributes: { createdAt: "1707-04-15T00:00:00", firstPlayerThrow: "RockPaperScissorsRock", matchInstanceId: 24, secondPlayerThrow: "RockPaperScissorsRock", updatedAt: "1707-04-15T00:00:00", roundWinnerId: 1, roundNumber: 1 } }
                , { id: 25, type: "rock_paper_scissors_rounds", attributes: { createdAt: "1707-04-15T00:00:00", firstPlayerThrow: "RockPaperScissorsRock", matchInstanceId: 25, secondPlayerThrow: "RockPaperScissorsRock", updatedAt: "1707-04-15T00:00:00", roundWinnerId: 1, roundNumber: 1 } }
                ]
        }|]
      it "includes the total number of rock paper scissors rounds in the response" pending
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
      it "responds with the requested page of rock paper scissors rounds" pending
    describe "with no page size query parameter" $ do
      it "responds with a 200" pending
      it "responds with Content-Type: application/json" pending
      it "responds with 25 rock paper scissors rounds" pending
      it "includes the total number of rock paper scissors rounds in the response" pending
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
      it "responds with the requested number of rock paper scissors rounds" pending
      it "includes the total number of rock paper scissors rounds in the response" pending

