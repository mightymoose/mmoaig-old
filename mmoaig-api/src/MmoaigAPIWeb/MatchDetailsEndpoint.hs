{-# LANGUAGE RecordWildCards   #-}
{-# LANGUAGE OverloadedStrings #-}
module MmoaigAPIWeb.MatchDetailsEndpoint (matchDetailsEndpoint, MatchDetailsEndpointData) where

import Data.Aeson (ToJSON, toJSON, object, (.=))
import Servant (Handler, err404, throwError)
import Control.Monad.IO.Class (liftIO)
import Database.PostgreSQL.Simple (Connection)

import MmoaigAPI.Matches (loadMatchDetails)

import MmoaigAPI.Schema (MatchTable, BotTable)

import MmoaigAPIWeb.Representers.APIResponse (ResourceIdentifier)
import MmoaigAPIWeb.Representers.MatchRepresenter (representMatch, MatchAttributes, MatchRelationships)

newtype MatchDetailsEndpointData = MatchDetailsEndpointData
  { endpointData :: ResourceIdentifier MatchAttributes MatchRelationships 
  }

instance ToJSON MatchDetailsEndpointData where
  toJSON MatchDetailsEndpointData{..} = object [ "data" .= endpointData ]

matchDetailsEndpoint :: Int -> Connection -> Handler MatchDetailsEndpointData
matchDetailsEndpoint matchId connection = do
  matches <- liftIO $ loadMatchDetails matchId connection
  case matches of 
    Just m -> return $ createResource m
    _      -> throwError err404

createResource :: (MatchTable, [BotTable]) -> MatchDetailsEndpointData
createResource matchDetails = MatchDetailsEndpointData endpointData 
  where 
    endpointData = uncurry representMatch matchDetails
