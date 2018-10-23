{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards   #-}
{-# LANGUAGE FlexibleContexts  #-}
module MmoaigAPIWeb.Representers.JSONApi ( ResourceIdentifier(ResourceIdentifier)
                                         , resourceIdentifierId
                                         , JSONAPIResponse(SuccessResponse, ErrorResponse)
                                         , resourceIdentifierType
                                         , ResourceObject(ResourceObject)
                                         , Error(Error)
                                         , PrimaryData( SingleResourceObject
                                                      , SingleResourceIdentifier
                                                      , NoResource
                                                      , ResourceObjects
                                                      , ResourceIdentifiers
                                                      )
                                         ) where

import Data.Aeson (ToJSON, toJSON, object, (.=), FromJSON, parseJSON, withObject, (.:), (.:?), Value(Object, Null), Object)
import GHC.Exts (fromList)
import Data.Monoid (mempty)

data PrimaryData a b = SingleResourceObject (ResourceObject a b)
                     | SingleResourceIdentifier ResourceIdentifier
                     | NoResource
                     | ResourceObjects [ResourceObject a b]
                     | ResourceIdentifiers [ResourceIdentifier]
                     deriving (Show, Eq)

newtype Error = Error String deriving (Show, Eq)

data JSONAPIResponse a b = SuccessResponse (PrimaryData a b)
                         | ErrorResponse [Error]
                         deriving (Show, Eq)

-- Add FromJSON instances for all of this stuff and test them
instance (ToJSON a, ToJSON b) => ToJSON (PrimaryData a b) where
  toJSON (SingleResourceObject i)     = toJSON i
  toJSON (SingleResourceIdentifier i) = toJSON i
  toJSON NoResource                   = Null
  toJSON (ResourceObjects i)          = toJSON i
  toJSON (ResourceIdentifiers i)      = toJSON i

instance ToJSON Error where
  toJSON (Error a) = toJSON a

instance (ToJSON a, ToJSON b) => ToJSON (JSONAPIResponse a b) where
  toJSON (SuccessResponse a) = object ["data"   .= a]
  toJSON (ErrorResponse a)   = object ["errors" .= a]

data ResourceIdentifier = ResourceIdentifier
  { resourceIdentifierId   :: Int
  , resourceIdentifierType :: String
  } deriving (Show, Eq)

instance ToJSON ResourceIdentifier where
  toJSON ResourceIdentifier{..} = object [ "id"   .= resourceIdentifierId
                                         , "type" .= resourceIdentifierType
                                         ]

instance FromJSON ResourceIdentifier where
  parseJSON = withObject "ResourceIdentifier" $ \o -> do
    resourceIdentifierId   <- o .: "id"
    resourceIdentifierType <- o .: "type"
    return ResourceIdentifier{..}

    
data ResourceObject a b = ResourceObject
  { resourceObjectIdentifier    :: ResourceIdentifier
  , resourceObjectAttributes    :: Maybe a
  , resourceObjectRelationships :: Maybe b
  } deriving (Show, Eq)

-- TODO: Test this
instance (ToJSON a, ToJSON b) => ToJSON (ResourceObject a b) where
  toJSON ResourceObject{..} = Object $
    toObject resourceObjectIdentifier <> 
      encodeAttributes resourceObjectAttributes <>
      encodeRelationships resourceObjectRelationships
      where
        encodeAttributes Nothing = mempty
        encodeAttributes _       = fromList ["attributes" .= resourceObjectAttributes]
        encodeRelationships Nothing = mempty
        encodeRelationships _       = fromList ["relationships" .= resourceObjectRelationships]

-- TODO: Test this
instance (FromJSON a, FromJSON b) => FromJSON (ResourceObject a b) where
  parseJSON = withObject "ResourceObject" $ \o -> do
    resourceObjectIdentifier    <- parseJSON (Object o)
    resourceObjectAttributes    <- o .:? "attributes" 
    resourceObjectRelationships <- o .:? "relationships" 
    return ResourceObject{..}

toObject :: ToJSON a => a -> Object
toObject a = case toJSON a of
  Object o -> o
  _        -> error "toObject: value isn't an Object"
