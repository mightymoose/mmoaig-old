module MmoaigAPISpecs.BotsSpec (spec) where

import Test.Hspec (Spec, parallel, pending, describe, it, around, shouldBe)
import Data.List (sort)

import TestUtilities (withDatabaseConnection)
import MmoaigAPI.Bots (loadBotList)
import MmoaigAPI.Schema (dbBotId)

spec :: Spec
spec = parallel $ around withDatabaseConnection $
  describe "MmoaigAPI.Bots" $ do
    describe "loadBotList" $ do
      it "loads the first page" $ const pending
      it "loads 25 results" $ \connection -> do
        bots <- loadBotList connection
        length bots `shouldBe` 25
      it "sorts the results by id" $ \connection -> do
        bots <- loadBotList connection 
        let botIds = map dbBotId bots
        botIds `shouldBe` sort botIds
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

