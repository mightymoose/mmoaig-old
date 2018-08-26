module MmoaigAPISpecs.MatchesSpec (spec) where

import Test.Hspec (Spec, parallel, pending, describe, it, around, shouldBe)
import Data.List (sort)

import TestUtilities (withDatabaseConnection)
import MmoaigAPI.Matches (loadMatchList, loadMatchDetails, updateMatch)
import MmoaigAPI.Schema (dbMatchId, DBMatchStatus(DBMatchCancelled), dbMatchStatus)

spec :: Spec
spec = parallel $ around withDatabaseConnection $
  describe "MmoaigAPI.Matches" $ do
    describe "updateMatch" $ do
      describe "when there is a match with the given id" $ do
        it "updates the match" $ \connection -> do
          _ <- updateMatch 1 DBMatchCancelled connection
          Just (match, _) <- loadMatchDetails 1 connection
          dbMatchStatus match `shouldBe` DBMatchCancelled
        it "returns the updated match" $ \connection -> do
          match <- updateMatch 1 DBMatchCancelled connection
          fmap dbMatchId match `shouldBe` Just 1
      describe "when there is no match with the given id" $ do
        it "returns Nothing" $ \connection -> do
          match <- updateMatch 1000 DBMatchCancelled connection
          match `shouldBe` Nothing
    describe "startNextMatch" $ do
      describe "when there is a pending match" $ do
        it "returns the match" $ const pending
        it "marks the match as in progress" $ const pending
      describe "when there is no pending match" $ do
        it "returns Nothing" $ const pending
    describe "loadMatchDetails" $ do
      describe "when there is not matching match" $ do
        it "returns Nothing" $ \connection -> do
          match <- loadMatchDetails 0 connection
          match `shouldBe` Nothing
      describe "when there is a matching match" $ do
        it "loads the match" $ \connection -> do
          Just (match, _) <- loadMatchDetails 1 connection
          dbMatchId match `shouldBe` 1
        it "loads the participants for the match" $ \connection -> do
          Just (_, participants) <- loadMatchDetails 1 connection
          length participants `shouldBe` 2
    describe "loadMatchList" $ do
      it "loads the first page" $ const pending
      it "loads 25 results" $ \connection -> do
        matches <- loadMatchList connection
        length matches `shouldBe` 25
      it "sorts the results by id" $ \connection -> do
        matches <- loadMatchList connection 
        let matchIds = map dbMatchId matches
        matchIds `shouldBe` sort matchIds
      it "loads the total number of results" $ const pending
    describe "with a page number query parameter of 0" $
      it "does things" $ const pending
    describe "with a negative page number query parameter" $
      it "does things" $ const pending
    describe "with a page parameter number which is too large" $
      it "does things" $ const pending
    describe "with a valid page number parameter" $
      it "does things" $ const pending
    describe "with a negative page size query parameter of 0" $
      it "does things" $ const pending
    describe "with a negative page size query parameter" $
      it "does things" $ const pending
    describe "with a page parameter size which is too large" $
      it "does things" $ const pending
    describe "with a valid page size parameter" $
      it "does things" $ const pending

