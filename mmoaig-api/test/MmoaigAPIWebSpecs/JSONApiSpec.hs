{-# LANGUAGE OverloadedStrings    #-}
{-# LANGUAGE DataKinds            #-}
module MmoaigAPIWebSpecs.JSONApiSpec (spec) where

import Test.Hspec (Spec, parallel, describe, it, shouldBe)
import Test.QuickCheck (property)
import Data.Aeson (encode, decode, (.=), object)
    
import Factory ()
import MmoaigAPIWeb.JSONApi ( ResourceIdentifier(ResourceIdentifier)
                            , ResourceObject(ResourceObject)
                            , JSONAPIResponse(SuccessResponse, ErrorResponse)
                            , Error(Error)
                            , PrimaryData( SingleResourceObject
                                         , SingleResourceIdentifier
                                         , NoResource
                                         , ResourceObjects
                                         , ResourceIdentifiers
                                         )
                            )

spec :: Spec
spec = parallel $
  describe "MmoaigAPIWeb.JSONApi" $ do
    describe "JSONAPIResponse" $ do
      it "can be converted to JSON" $
        property jsonAPIResponseRepresentableAsJSON
    describe "Error" $ do
      it "can be converted to JSON" $
        property errorRepresentableAsJSON
    describe "PrimaryData" $ do
      it "can be converted to JSON" $
        property primaryDataRepresentableAsJSON
    describe "ResourceIdentifier" $ 
      it "can be converted to and from JSON" $
        property resourceIdentifierRepresentableAsJSON
    describe "ResourceObject" $ do
      it "can be converted to and from JSON" $ 
        property resourceObjectRepresentableAsJSON
      describe "converting to JSON" $
        describe "when resourceObjectAttributes is Nothing" $
          it "omits the attributes key from the JSON" $ do
            let resourceIdentifier = ResourceIdentifier 1 "type"
            let resourceObject = ResourceObject resourceIdentifier Nothing :: ResourceObject Int
            encode resourceObject `shouldBe` "{\"id\":1,\"type\":\"type\"}"

resourceIdentifierRepresentableAsJSON :: ResourceIdentifier -> Bool
resourceIdentifierRepresentableAsJSON i = (decode . encode) i == Just i
      
resourceObjectRepresentableAsJSON :: ResourceObject Int -> Bool
resourceObjectRepresentableAsJSON r = (decode . encode) r == Just r

errorRepresentableAsJSON :: Error -> Bool
errorRepresentableAsJSON r@(Error m) = encode r == encode m

jsonAPIResponseRepresentableAsJSON :: JSONAPIResponse Int -> Bool
jsonAPIResponseRepresentableAsJSON r@(SuccessResponse d) = encode r == (encode . object) [ "data" .= d ]
jsonAPIResponseRepresentableAsJSON r@(ErrorResponse m) = encode r == (encode . object) [ "errors" .= m ]

      
primaryDataRepresentableAsJSON ::  PrimaryData Int -> Bool
primaryDataRepresentableAsJSON d@(SingleResourceObject o) = encode d == encode o
primaryDataRepresentableAsJSON d@(SingleResourceIdentifier i) = encode d == encode i
primaryDataRepresentableAsJSON d@NoResource = encode d == "null"
primaryDataRepresentableAsJSON d@(ResourceObjects o) = encode d == encode o
primaryDataRepresentableAsJSON d@(ResourceIdentifiers i) = encode d == encode i
