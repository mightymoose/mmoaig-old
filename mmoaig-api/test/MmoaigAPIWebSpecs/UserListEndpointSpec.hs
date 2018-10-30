{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}
module MmoaigAPIWebSpecs.UserListEndpointSpec (spec) where

import Test.Hspec (Spec, parallel, describe, it)
import Test.Hspec.Wai (with, pending, shouldRespondWith, get, matchHeaders, (<:>))
import Test.Hspec.Wai.JSON (json)
    
import TestUtilities (testApp)

spec :: Spec
spec = parallel $ with testApp $
  describe "MmoaigAPIWeb.UserListEndpoint" $ do
    describe "with no page number query parameter" $ do
      it "responds with a 200" $
        get "v1/users" `shouldRespondWith` 200
      it "responds with Content-Type: application/json" $
        get "v1/users" `shouldRespondWith` 200 {matchHeaders = ["Content-Type" <:> "application/json;charset=utf-8"]}
      it "responds with the first page of users" $
        get "v1/users" `shouldRespondWith` [json|{
          data: [ { id: 1 , type: "users", attributes: {username: "MightyMoose" , active: true , createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00"} }
                , { id: 2 , type: "users", attributes: {username: "User #2"     , active: false, createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00"} }
                , { id: 3 , type: "users", attributes: {username: "User #3"     , active: false, createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00"} }
                , { id: 4 , type: "users", attributes: {username: "User #4"     , active: false, createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00"} }
                , { id: 5 , type: "users", attributes: {username: "User #5"     , active: false, createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00"} }
                , { id: 6 , type: "users", attributes: {username: "User #6"     , active: false, createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00"} }
                , { id: 7 , type: "users", attributes: {username: "User #7"     , active: false, createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00"} }
                , { id: 8 , type: "users", attributes: {username: "User #8"     , active: false, createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00"} }
                , { id: 9 , type: "users", attributes: {username: "User #9"     , active: false, createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00"} }
                , { id: 10, type: "users", attributes: {username: "User #10"    , active: false, createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00"} }
                , { id: 11, type: "users", attributes: {username: "User #11"    , active: false, createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00"} }
                , { id: 12, type: "users", attributes: {username: "User #12"    , active: false, createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00"} }
                , { id: 13, type: "users", attributes: {username: "User #13"    , active: false, createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00"} }
                , { id: 14, type: "users", attributes: {username: "User #14"    , active: false, createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00"} }
                , { id: 15, type: "users", attributes: {username: "User #15"    , active: false, createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00"} }
                , { id: 16, type: "users", attributes: {username: "User #16"    , active: false, createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00"} }
                , { id: 17, type: "users", attributes: {username: "User #17"    , active: false, createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00"} }
                , { id: 18, type: "users", attributes: {username: "User #18"    , active: false, createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00"} }
                , { id: 19, type: "users", attributes: {username: "User #19"    , active: false, createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00"} }
                , { id: 20, type: "users", attributes: {username: "User #20"    , active: false, createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00"} }
                , { id: 21, type: "users", attributes: {username: "User #21"    , active: false, createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00"} }
                , { id: 22, type: "users", attributes: {username: "User #22"    , active: false, createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00"} }
                , { id: 23, type: "users", attributes: {username: "User #23"    , active: false, createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00"} }
                , { id: 24, type: "users", attributes: {username: "User #24"    , active: false, createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00"} }
                , { id: 25, type: "users", attributes: {username: "User #25"    , active: false, createdAt: "1707-04-15T00:00:00", updatedAt: "1707-04-15T00:00:00"} }
                ]
        }|]
      it "includes the total number of users in the response" pending
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
      it "responds with the requested page of users" pending
    describe "with no page size query parameter" $ do
      it "responds with a 200" pending
      it "responds with Content-Type: application/json" pending
      it "responds with 25 users" pending
      it "includes the total number of users in the response" pending
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
      it "responds with the requested number of users" pending
      it "includes the total number of users in the response" pending

