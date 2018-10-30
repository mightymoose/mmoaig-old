module MmoaigAPISpecs.MatchInstancesSpec (spec) where

import Test.Hspec (Spec, parallel, pending, describe, it, around, shouldBe)
import Data.List (sort)

import TestUtilities (withDatabaseConnection)
import MmoaigAPI.MatchInstances (loadMatchInstanceList, mostRecentInstanceForMatch)
import MmoaigAPI.Schema (dbMatchInstanceId)

spec :: Spec
spec = parallel $ around withDatabaseConnection $
  describe "MmoaigAPI.MatchInstances" $ do
    describe "mostRecentInstanceForMatch" $ do
      describe "when the match doesn't exist" $
        it "returns Nothing" $ \connection -> do
          i <- mostRecentInstanceForMatch 100000 connection 
          i `shouldBe` Nothing
      describe "when the match doesn't have instances" $ 
        it "returns Nothing" $ \connection -> do
          i <- mostRecentInstanceForMatch 1 connection 
          i `shouldBe` Nothing
      describe "when the match exists and has instances" $
        it "returns the match" $ \connection -> do
          i <- mostRecentInstanceForMatch 2 connection 
          dbMatchInstanceId <$> i `shouldBe` Just 99
    describe "loadMatchInstanceList" $ do
      describe "with no match id filter" $ do
        describe "with no page number query parameter" $
          it "has a bunch of tests" $ const pending
        it "loads the first page" $ const pending
        it "loads 25 results" $ \connection -> do
          instances <- loadMatchInstanceList Nothing connection
          length instances `shouldBe` 25
        it "sorts the results by id" $ \connection -> do
          instances <- loadMatchInstanceList Nothing connection 
          let instanceIds = map dbMatchInstanceId instances
          instanceIds `shouldBe` sort instanceIds
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
    describe "with a match id filter" $ do
      it "loads the first page" $ const pending
      it "loads 25 results" $ \connection -> do
        instances <- loadMatchInstanceList (Just 3) connection
        length instances `shouldBe` 25
      it "sorts the results by id" $ \connection -> do
        instances <- loadMatchInstanceList (Just 3) connection 
        let instanceIds = map dbMatchInstanceId instances
        instanceIds `shouldBe` sort instanceIds
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

