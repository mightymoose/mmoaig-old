{-# LANGUAGE GADTs             #-}
{-# LANGUAGE OverloadedStrings #-}
module MmoaigAPIWeb.Representers.APIResponse (APIResponse(APIResponse), ResourceIdentifier(ResourceIdentifier, ResourceIdentifierWithRelationships)) where

import Data.Aeson (ToJSON, toJSON, object, (.=))

data APIResponse t where
  APIResponse   :: [ResourceIdentifier t u] -> APIResponse t

instance ToJSON (APIResponse t) where
  toJSON (APIResponse t) = object [ "data" .= t ]

data ResourceIdentifier t u where
  ResourceIdentifier :: ToJSON t => Int -> String -> t -> ResourceIdentifier t u
  ResourceIdentifierWithRelationships :: (ToJSON t, ToJSON u) => Int -> String -> t -> u -> ResourceIdentifier t u

instance ToJSON (ResourceIdentifier t u) where
  toJSON (ResourceIdentifier i s t) = object [ "id"         .= i
                                             , "type"       .= s
                                             , "attributes" .= t
                                             ]
  toJSON (ResourceIdentifierWithRelationships i s t u) = object [ "id"            .= i
                                                                , "type"          .= s
                                                                , "attributes"    .= t
                                                                , "relationships" .= u
                                                                ]
