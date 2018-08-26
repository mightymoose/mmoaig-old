module MmoaigAPISpecs.GameSpecs.RockPaperScissorsSpec (spec)  where

import Test.Hspec (Spec, describe, it, context, parallel, shouldSatisfy, shouldBe)
import Test.QuickCheck (property, Positive(Positive))
import Data.Either (isLeft, isRight)

import MmoaigAPI.Games.RockPaperScissors ( addRound
                                         , createFirstPastThePostMatch
                                         , firstPlayerScore
                                         , matchScore
                                         , matchWinner
                                         , Player(FirstPlayer, SecondPlayer)
                                         , Round(Round)
                                         , secondPlayerScore
                                         , Throw(Rock, Scissors)
                                         )

spec :: Spec
spec = parallel $
  describe "MmoaigAPI.RockPaperScissors" $ do
    describe "createFirstPastThePostMatch" $ do
      context "when called with 0" $
        it "returns an error" $ 
          createFirstPastThePostMatch 0 `shouldSatisfy` isLeft
      context "when called with a negative number" $
        it "returns an error" $ property $
          \(Positive n) -> isLeft $ createFirstPastThePostMatch (-n)
      context "when called with a positive number" $ do
        it "creates a match" $ property $ 
          \(Positive n) -> isRight $ createFirstPastThePostMatch n
        it "has a first player score of 0" $ property $
          \(Positive n) -> (firstPlayerScore . matchScore <$> createFirstPastThePostMatch n) == Right 0
        it "has a second player score of 0" $ property $
          \(Positive n) -> (secondPlayerScore . matchScore <$> createFirstPastThePostMatch n) == Right 0
        it "does not have a winner" $ property $
          \(Positive n) ->  (matchWinner <$> createFirstPastThePostMatch n) == Right Nothing
    let match = createFirstPastThePostMatch 1
    let roundWonByFirstPlayer = Round Rock Scissors
    let roundWonBySecondPlayer = Round Scissors Rock
    let drawnRound = Round Rock Rock
    describe "addRound" $ do
      let completeMatch = match >>= addRound roundWonByFirstPlayer
      it "creates a match" $
        completeMatch `shouldSatisfy` isRight
      context "when the match has completed" $
        it "returns an error" $ 
          (completeMatch >>= addRound roundWonByFirstPlayer) `shouldSatisfy` isLeft
      context "when the match has not ended" $ do
        context "when the first player wins the round" $ do
          let wonByFirstPlayer = match >>= addRound roundWonByFirstPlayer
          it "increments the first player's score" $ 
            (firstPlayerScore . matchScore <$> wonByFirstPlayer) `shouldBe` Right 1
          it "does not increment the second player's score" $ 
            (secondPlayerScore . matchScore <$> wonByFirstPlayer) `shouldBe` Right 0
        context "when the second player wins the round" $ do
          let wonBySecondPlayer = match >>= addRound roundWonBySecondPlayer
          it "increments the second player's score" $ 
            (secondPlayerScore . matchScore <$> wonBySecondPlayer) `shouldBe` Right 1
          it "does not increment the first player's score" $ 
            (firstPlayerScore . matchScore <$> wonBySecondPlayer) `shouldBe` Right 0
        context "when nobody wins the round" $ do
          let drawn = match >>= addRound drawnRound
          it "does not increment the first player's score" $ 
            (firstPlayerScore . matchScore <$> drawn) `shouldBe` Right 0
          it "does not increment the second player's score" $
            (secondPlayerScore . matchScore <$> drawn) `shouldBe` Right 0
    describe "matchWinner" $ do
      context "with an incomplete match" $
        it "returns Nothing" $
          (matchWinner <$> (match >>= addRound drawnRound)) `shouldBe` Right Nothing
      context "with a match won by the first player" $
        it "returns Just FirstPlayer" $
          (matchWinner <$> (match >>= addRound roundWonByFirstPlayer)) `shouldBe` Right (Just FirstPlayer)
      context "with a match won by the second player" $
        it "returns Just FirstPlayer" $
          (matchWinner <$> (match >>= addRound roundWonBySecondPlayer)) `shouldBe` Right (Just SecondPlayer)
