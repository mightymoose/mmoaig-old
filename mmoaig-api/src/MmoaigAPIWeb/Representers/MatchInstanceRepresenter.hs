{-# LANGUAGE RecordWildCards   #-}
{-# LANGUAGE OverloadedStrings #-}
module MmoaigAPIWeb.Representers.MatchInstanceRepresenter (createMatchInstanceIdentifier, createMatchInstanceObject, MatchInstanceAttributes) where

import Data.Aeson (ToJSON, toJSON, FromJSON, parseJSON, object, (.=), withObject, (.:))

import MmoaigAPI.Schema (MatchInstanceTable, MatchInstanceTableT(MatchInstanceTable), dbMatchInstanceId, dbMatchInstanceToken)
import MmoaigAPIWeb.Representers.JSONApi(ResourceIdentifier(ResourceIdentifier), ResourceObject(ResourceObject))

newtype MatchInstanceAttributes = MatchInstanceAttributes
  { matchInstanceToken   :: String
  }

-- TODO: Test this
instance ToJSON MatchInstanceAttributes where
  toJSON MatchInstanceAttributes{..} = object [ "matchInstanceToken" .= matchInstanceToken ]

-- TODO: Test this
instance FromJSON MatchInstanceAttributes where
  parseJSON = withObject "MatchInstanceAttributes" $ \o -> do
    matchInstanceToken   <- o .: "matchInstanceToken"
    return MatchInstanceAttributes{..}

-- TODO: Test this
createMatchInstanceIdentifier :: MatchInstanceTable -> ResourceIdentifier
createMatchInstanceIdentifier MatchInstanceTable{..} = ResourceIdentifier dbMatchInstanceId "match_instances"

-- TODO: Test this
createMatchInstanceObject :: MatchInstanceTable -> ResourceObject MatchInstanceAttributes ()
createMatchInstanceObject matchInstance@MatchInstanceTable{..} = ResourceObject identifier (Just attributes) Nothing
  where
    attributes = MatchInstanceAttributes dbMatchInstanceToken
    identifier = createMatchInstanceIdentifier matchInstance
