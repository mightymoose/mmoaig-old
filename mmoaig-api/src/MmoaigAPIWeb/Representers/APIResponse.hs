{-# LANGUAGE GADTs             #-}
{-# LANGUAGE OverloadedStrings #-}
module MmoaigAPIWeb.Representers.APIResponse (APIResponse(APIResponse), ResourceIdentifier(ResourceIdentifier)) where

import Data.Aeson (ToJSON, toJSON, object, (.=))

data APIResponse t where
  APIResponse   :: [ResourceIdentifier t] -> APIResponse t

instance ToJSON (APIResponse t) where
  toJSON (APIResponse t) = object [ "data" .= t ]

data ResourceIdentifier t where
  ResourceIdentifier :: ToJSON t => Int -> String -> t -> ResourceIdentifier t

instance ToJSON (ResourceIdentifier t) where
  toJSON (ResourceIdentifier i s t) = object [ "id"         .= i
                                             , "type"       .= s
                                             , "attributes" .= t
                                             ]
