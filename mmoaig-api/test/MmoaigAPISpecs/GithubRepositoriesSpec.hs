module MmoaigAPISpecs.GithubRepositoriesSpec (spec) where

import Test.Hspec (Spec, parallel, pending, describe, it, around, shouldBe)
import Data.List (sort)

import TestUtilities (withDatabaseConnection)
import MmoaigAPI.GithubRepositories (loadGithubRepositoryList)
import MmoaigAPI.Schema (dbGithubRepositoryId)

spec :: Spec
spec = parallel $ around withDatabaseConnection $
  describe "MmoaigAPI.GithubRepositories" $ do
    describe "loadGithubRepositoryList" $ do
      it "loads the first page" $ const pending
      it "loads 25 results" $ \connection -> do
        repositories <- loadGithubRepositoryList connection
        length repositories `shouldBe` 25
      it "sorts the results by id" $ \connection -> do
        repositories <- loadGithubRepositoryList connection 
        let repositoryIds = map dbGithubRepositoryId repositories
        repositoryIds `shouldBe` sort repositoryIds
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

