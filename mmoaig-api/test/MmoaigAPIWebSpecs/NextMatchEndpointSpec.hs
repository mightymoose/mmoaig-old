{-# LANGUAGE OverloadedStrings #-}
module MmoaigAPIWebSpecs.NextMatchEndpointSpec (spec) where

import Test.Hspec (Spec, parallel, describe, it)
import Test.Hspec.Wai (pending, with)

import TestUtilities (testApp)

spec :: Spec
spec = parallel $ with testApp $ 
  describe "the tests" $
    it "pass" $ pending

