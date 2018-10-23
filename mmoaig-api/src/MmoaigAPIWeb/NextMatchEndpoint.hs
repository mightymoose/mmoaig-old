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
import MmoaigAPIWeb.Representers.MatchRepresenter (representMatch, MatchAttributes, MatchRelationships)

newtype NextMatchEndpointData = NextMatchEndpointData
  { endpointData :: ResourceIdentifier MatchAttributes MatchRelationships
  }

instance ToJSON NextMatchEndpointData where
  toJSON NextMatchEndpointData{..} = object [ "data" .= endpointData ]

nextMatchEndpoint ::  Connection -> Handler NextMatchEndpointData
nextMatchEndpoint connection = do
  matches <- liftIO $ loadNextMatch connection
  case matches of 
    Just (m, b, _) -> return $ createResource (m, b)
    _      -> throwError err404

createResource :: (MatchTable, [BotTable]) -> NextMatchEndpointData
createResource matchDetails = NextMatchEndpointData endpointData
  where 
    endpointData = uncurry representMatch matchDetails
