{-# LANGUAGE OverloadedStrings    #-}
{-# LANGUAGE DataKinds            #-}
module MmoaigAPIWebSpecs.RepresentersSpecs.GithubRepositoryRepresenterSpec (spec) where

import Test.Hspec (Spec, it, describe, pending, parallel)

import MmoaigAPIWeb.Representers.GithubRepositoryRepresenter ()

spec :: Spec
spec = parallel $
  describe "MmoaigAPIWeb.Representers.GithubRepositoryRepresenter" $ do
    describe "JSONAPIResponse" $ 
      it "can be converted to JSON" $ pending