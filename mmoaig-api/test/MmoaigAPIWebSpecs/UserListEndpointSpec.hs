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
          data: [ { id: 1 , type: "users", attributes: {username: "MightyMoose" , active: true} }
                , { id: 2 , type: "users", attributes: {username: "User #2"     , active: false} }
                , { id: 3 , type: "users", attributes: {username: "User #3"     , active: false} }
                , { id: 4 , type: "users", attributes: {username: "User #4"     , active: false} }
                , { id: 5 , type: "users", attributes: {username: "User #5"     , active: false} }
                , { id: 6 , type: "users", attributes: {username: "User #6"     , active: false} }
                , { id: 7 , type: "users", attributes: {username: "User #7"     , active: false} }
                , { id: 8 , type: "users", attributes: {username: "User #8"     , active: false} }
                , { id: 9 , type: "users", attributes: {username: "User #9"     , active: false} }
                , { id: 10, type: "users", attributes: {username: "User #10"    , active: false} }
                , { id: 11, type: "users", attributes: {username: "User #11"    , active: false} }
                , { id: 12, type: "users", attributes: {username: "User #12"    , active: false} }
                , { id: 13, type: "users", attributes: {username: "User #13"    , active: false} }
                , { id: 14, type: "users", attributes: {username: "User #14"    , active: false} }
                , { id: 15, type: "users", attributes: {username: "User #15"    , active: false} }
                , { id: 16, type: "users", attributes: {username: "User #16"    , active: false} }
                , { id: 17, type: "users", attributes: {username: "User #17"    , active: false} }
                , { id: 18, type: "users", attributes: {username: "User #18"    , active: false} }
                , { id: 19, type: "users", attributes: {username: "User #19"    , active: false} }
                , { id: 20, type: "users", attributes: {username: "User #20"    , active: false} }
                , { id: 21, type: "users", attributes: {username: "User #21"    , active: false} }
                , { id: 22, type: "users", attributes: {username: "User #22"    , active: false} }
                , { id: 23, type: "users", attributes: {username: "User #23"    , active: false} }
                , { id: 24, type: "users", attributes: {username: "User #24"    , active: false} }
                , { id: 25, type: "users", attributes: {username: "User #25"    , active: false} }
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

