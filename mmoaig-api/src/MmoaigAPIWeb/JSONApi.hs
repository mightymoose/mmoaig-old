{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards   #-}
{-# LANGUAGE FlexibleContexts  #-}
module MmoaigAPIWeb.JSONApi ( ResourceIdentifier(ResourceIdentifier)
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

data PrimaryData a = SingleResourceObject (ResourceObject a)
                   | SingleResourceIdentifier ResourceIdentifier
                   | NoResource
                   | ResourceObjects [ResourceObject a]
                   | ResourceIdentifiers [ResourceIdentifier]
                   deriving (Show, Eq)

newtype Error = Error String deriving (Show, Eq)

data JSONAPIResponse a = SuccessResponse (PrimaryData a)
                       | ErrorResponse [Error]
                       deriving (Show, Eq)

instance (ToJSON a) => ToJSON (PrimaryData a) where
  toJSON (SingleResourceObject i)     = toJSON i
  toJSON (SingleResourceIdentifier i) = toJSON i
  toJSON NoResource                   = Null
  toJSON (ResourceObjects i)          = toJSON i
  toJSON (ResourceIdentifiers i)      = toJSON i

instance ToJSON Error where
  toJSON (Error a) = toJSON a

instance (ToJSON a) => ToJSON (JSONAPIResponse a) where
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

    
data ResourceObject a = ResourceObject
  { resourceObjectIdentifier :: ResourceIdentifier
  , resourceObjectAttributes :: Maybe a
  } deriving (Show, Eq)

instance (ToJSON a) => ToJSON (ResourceObject a) where
  toJSON ResourceObject{..} = Object $
    toObject resourceObjectIdentifier <> 
      encodeAttributes resourceObjectAttributes
      where
        encodeAttributes Nothing = mempty
        encodeAttributes _       = fromList ["attributes" .= resourceObjectAttributes]

instance (FromJSON a) => FromJSON (ResourceObject a) where
  parseJSON = withObject "ResourceObject" $ \o -> do
    resourceObjectIdentifier <- parseJSON (Object o)
    resourceObjectAttributes <- o .:? "attributes" 
    return ResourceObject{..}

toObject :: ToJSON a => a -> Object
toObject a = case toJSON a of
  Object o -> o
  _        -> error "toObject: value isn't an Object"
