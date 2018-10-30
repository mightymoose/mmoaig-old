{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}
module MmoaigAPIWebSpecs.GithubRepositoryListEndpointSpec (spec) where

import Test.Hspec (Spec, parallel, describe, it)
import Test.Hspec.Wai (with, pending, shouldRespondWith, get, matchHeaders, (<:>))
import Test.Hspec.Wai.JSON (json)
    
import TestUtilities (testApp)

spec :: Spec
spec = parallel $ with testApp $
  describe "MmoaigAPIWeb.GithubRepositoryListEndpoint" $ do
    describe "with no page number query parameter" $ do
      it "responds with a 200" $
        get "v1/github-repositories" `shouldRespondWith` 200
      it "responds with Content-Type: application/json" $
        get "v1/github-repositories" `shouldRespondWith` 200 {matchHeaders = ["Content-Type" <:> "application/json;charset=utf-8"]}
      it "responds with the first page of github repositories" $
        get "v1/github-repositories" `shouldRespondWith` [json|{
          data: [ { id: 1 , type: "github_repositories", attributes: {name: "bots"         , createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00", githubUserId: 1} }
                , { id: 2 , type: "github_repositories", attributes: {name: "fake_repo #2" , createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00", githubUserId: 2} }
                , { id: 3 , type: "github_repositories", attributes: {name: "fake_repo #3" , createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00", githubUserId: 3} }
                , { id: 4 , type: "github_repositories", attributes: {name: "fake_repo #4" , createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00", githubUserId: 4} }
                , { id: 5 , type: "github_repositories", attributes: {name: "fake_repo #5" , createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00", githubUserId: 5} }
                , { id: 6 , type: "github_repositories", attributes: {name: "fake_repo #6" , createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00", githubUserId: 6} }
                , { id: 7 , type: "github_repositories", attributes: {name: "fake_repo #7" , createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00", githubUserId: 7} }
                , { id: 8 , type: "github_repositories", attributes: {name: "fake_repo #8" , createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00", githubUserId: 8} }
                , { id: 9 , type: "github_repositories", attributes: {name: "fake_repo #9" , createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00", githubUserId: 9} }
                , { id: 10, type: "github_repositories", attributes: {name: "fake_repo #10", createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00", githubUserId: 10} }
                , { id: 11, type: "github_repositories", attributes: {name: "fake_repo #11", createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00", githubUserId: 11} }
                , { id: 12, type: "github_repositories", attributes: {name: "fake_repo #12", createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00", githubUserId: 12} }
                , { id: 13, type: "github_repositories", attributes: {name: "fake_repo #13", createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00", githubUserId: 13} }
                , { id: 14, type: "github_repositories", attributes: {name: "fake_repo #14", createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00", githubUserId: 14} }
                , { id: 15, type: "github_repositories", attributes: {name: "fake_repo #15", createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00", githubUserId: 15} }
                , { id: 16, type: "github_repositories", attributes: {name: "fake_repo #16", createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00", githubUserId: 16} }
                , { id: 17, type: "github_repositories", attributes: {name: "fake_repo #17", createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00", githubUserId: 17} }
                , { id: 18, type: "github_repositories", attributes: {name: "fake_repo #18", createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00", githubUserId: 18} }
                , { id: 19, type: "github_repositories", attributes: {name: "fake_repo #19", createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00", githubUserId: 19} }
                , { id: 20, type: "github_repositories", attributes: {name: "fake_repo #20", createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00", githubUserId: 20} }
                , { id: 21, type: "github_repositories", attributes: {name: "fake_repo #21", createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00", githubUserId: 21} }
                , { id: 22, type: "github_repositories", attributes: {name: "fake_repo #22", createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00", githubUserId: 22} }
                , { id: 23, type: "github_repositories", attributes: {name: "fake_repo #23", createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00", githubUserId: 23} }
                , { id: 24, type: "github_repositories", attributes: {name: "fake_repo #24", createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00", githubUserId: 24} }
                , { id: 25, type: "github_repositories", attributes: {name: "fake_repo #25", createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00", githubUserId: 25} }
                ]
        }|]
      it "includes the total number of github repositories in the response" pending
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
      it "responds with the requested page of github repositories" pending
    describe "with no page size query parameter" $ do
      it "responds with a 200" pending
      it "responds with Content-Type: application/json" pending
      it "responds with 25 github repositories" pending
      it "includes the total number of github repositories in the response" pending
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
      it "responds with the requested number of github repositories" pending
      it "includes the total number of github repositories in the response" pending

