{-# LANGUAGE OverloadedStrings    #-}
{-# LANGUAGE DataKinds            #-}
module MmoaigAPIWebSpecs.RepresentersSpecs.GithubUserRepresenterSpec (spec) where

import Test.Hspec (Spec, it, describe, pending, parallel)

import MmoaigAPIWeb.Representers.GithubUserRepresenter ()

spec :: Spec
spec = parallel $
  describe "MmoaigAPIWeb.Representers.GithubUserRepresenter" $ do
    describe "JSONAPIResponse" $ 
      it "can be converted to JSON" $ pending