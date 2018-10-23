{-# OPTIONS_GHC -fno-warn-orphans #-}
module Factory where

import Test.QuickCheck (Arbitrary, arbitrary, oneof)
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

instance Arbitrary ResourceIdentifier where
  arbitrary = ResourceIdentifier <$> arbitrary <*> arbitrary

instance (Arbitrary a) => Arbitrary (ResourceObject a) where
  arbitrary = ResourceObject <$> arbitrary <*> arbitrary

instance (Arbitrary a) => Arbitrary (PrimaryData a) where
  arbitrary = oneof [ SingleResourceObject <$> arbitrary 
                    , SingleResourceIdentifier <$> arbitrary
                    , pure NoResource
                    , ResourceObjects <$> arbitrary
                    , ResourceIdentifiers <$> arbitrary
                    ]

instance Arbitrary Error where
  arbitrary = Error <$> arbitrary

instance (Arbitrary a) => Arbitrary (JSONAPIResponse a) where
  arbitrary = oneof [ SuccessResponse <$> arbitrary
                    , ErrorResponse <$> arbitrary
                    ]
      
