{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}
module MmoaigAPIWebSpecs.GithubUserListEndpointSpec (spec) where

import Test.Hspec (Spec, parallel, describe, it)
import Test.Hspec.Wai (with, pending, shouldRespondWith, get, matchHeaders, (<:>))
import Test.Hspec.Wai.JSON (json)
    
import TestUtilities (testApp)

spec :: Spec
spec = parallel $ with testApp $
  describe "MmoaigAPIWeb.UserListEndpoint" $ do
    describe "with no page number query parameter" $ do
      it "responds with a 200" $
        get "v1/github-users" `shouldRespondWith` 200
      it "responds with Content-Type: application/json" $
        get "v1/github-users" `shouldRespondWith` 200 {matchHeaders = ["Content-Type" <:> "application/json;charset=utf-8"]}
      it "responds with the first page of github-users" $
        get "v1/github-users" `shouldRespondWith` [json|{
          data: [ { id: 1 , type: "github_users", attributes: {username: "mightymoose",     createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00", userId: 1} }
                , { id: 2 , type: "github_users", attributes: {username: "github_user #2",  createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00", userId: 2} }
                , { id: 3 , type: "github_users", attributes: {username: "github_user #3",  createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00", userId: 3} }
                , { id: 4 , type: "github_users", attributes: {username: "github_user #4" , createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00", userId: 4} }
                , { id: 5 , type: "github_users", attributes: {username: "github_user #5" , createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00", userId: 5} }
                , { id: 6 , type: "github_users", attributes: {username: "github_user #6" , createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00", userId: 6} }
                , { id: 7 , type: "github_users", attributes: {username: "github_user #7" , createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00", userId: 7} }
                , { id: 8 , type: "github_users", attributes: {username: "github_user #8" , createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00", userId: 8} }
                , { id: 9 , type: "github_users", attributes: {username: "github_user #9" , createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00", userId: 9} }
                , { id: 10, type: "github_users", attributes: {username: "github_user #10", createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00", userId: 10} }
                , { id: 11, type: "github_users", attributes: {username: "github_user #11", createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00", userId: 11} }
                , { id: 12, type: "github_users", attributes: {username: "github_user #12", createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00", userId: 12} }
                , { id: 13, type: "github_users", attributes: {username: "github_user #13", createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00", userId: 13} }
                , { id: 14, type: "github_users", attributes: {username: "github_user #14", createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00", userId: 14} }
                , { id: 15, type: "github_users", attributes: {username: "github_user #15", createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00", userId: 15} }
                , { id: 16, type: "github_users", attributes: {username: "github_user #16", createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00", userId: 16} }
                , { id: 17, type: "github_users", attributes: {username: "github_user #17", createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00", userId: 17} }
                , { id: 18, type: "github_users", attributes: {username: "github_user #18", createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00", userId: 18} }
                , { id: 19, type: "github_users", attributes: {username: "github_user #19", createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00", userId: 19} }
                , { id: 20, type: "github_users", attributes: {username: "github_user #20", createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00", userId: 20} }
                , { id: 21, type: "github_users", attributes: {username: "github_user #21", createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00", userId: 21} }
                , { id: 22, type: "github_users", attributes: {username: "github_user #22", createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00", userId: 22} }
                , { id: 23, type: "github_users", attributes: {username: "github_user #23", createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00", userId: 23} }
                , { id: 24, type: "github_users", attributes: {username: "github_user #24", createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00", userId: 24} }
                , { id: 25, type: "github_users", attributes: {username: "github_user #25", createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00", userId: 25} }
                ]
        }|]
      it "includes the total number of github users in the response" pending
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
      it "responds with the requested page of github users" pending
    describe "with no page size query parameter" $ do
      it "responds with a 200" pending
      it "responds with Content-Type: application/json" pending
      it "responds with 25 github users" pending
      it "includes the total number of github users in the response" pending
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
      it "responds with the requested number of github users" pending
      it "includes the total number of github users in the response" pending

