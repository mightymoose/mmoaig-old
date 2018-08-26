{-# LANGUAGE DeriveGeneric     #-}
{-# LANGUAGE RecordWildCards   #-}
{-# LANGUAGE OverloadedStrings #-}
module MmoaigAPIWeb.NextMatchEndpoint (nextMatchEndpoint, NextMatchEndpointData) where

import Data.Aeson (ToJSON, toJSON, object, (.=))
import Servant (Handler, err404, throwError)
import Control.Monad.IO.Class (liftIO)
import Database.PostgreSQL.Simple (Connection)

import MmoaigAPI.Matches (loadNextMatch)

import MmoaigAPI.Schema (MatchTable, BotTable)

import MmoaigAPIWeb.Representers.APIResponse (ResourceIdentifier)
import MmoaigAPIWeb.Representers.BotRepresenter (BotAttributes, representBot)
import MmoaigAPIWeb.Representers.MatchRepresenter (representMatch, MatchAttributes)

data NextMatchEndpointRelationship = NextMatchEndpointRelationship
  { nextMatchEndpointRelationshipData :: [ResourceIdentifier BotAttributes]
  }

instance ToJSON NextMatchEndpointRelationship where
  toJSON NextMatchEndpointRelationship{..} = object [ "data" .= nextMatchEndpointRelationshipData ]

data NextMatchEndpointData = NextMatchEndpointData
  { endpointData          :: ResourceIdentifier MatchAttributes
  , endpointRelationships :: NextMatchEndpointRelationship
  }

instance ToJSON NextMatchEndpointData where
  toJSON NextMatchEndpointData{..} = object [ "data" .= endpointData
                                            , "relationships" .= object ["participants" .= endpointRelationships]
                                            ]

nextMatchEndpoint ::  Connection -> Handler NextMatchEndpointData
nextMatchEndpoint connection = do
  matches <- liftIO $ loadNextMatch connection
  case matches of 
    Just m -> return $ createResource m
    _      -> throwError err404

createResource :: (MatchTable, [BotTable]) -> NextMatchEndpointData
createResource matchDetails = NextMatchEndpointData endpointData relationships
  where 
    endpointData = representMatch $ fst matchDetails
    relationships = NextMatchEndpointRelationship $ map representBot (snd matchDetails)
