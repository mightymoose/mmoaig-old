{-# LANGUAGE DeriveGeneric     #-}
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
import MmoaigAPIWeb.Representers.BotRepresenter (BotAttributes, representBot)
import MmoaigAPIWeb.Representers.MatchRepresenter (representMatch, MatchAttributes)

data MatchDetailsEndpointRelationship = MatchDetailsEndpointRelationship
  { matchDetailsEndpointRelationshipData :: [ResourceIdentifier BotAttributes]
  }

instance ToJSON MatchDetailsEndpointRelationship where
  toJSON MatchDetailsEndpointRelationship{..} = object [ "data" .= matchDetailsEndpointRelationshipData ]

data MatchDetailsEndpointData = MatchDetailsEndpointData
  { endpointData          :: ResourceIdentifier MatchAttributes
  , endpointRelationships :: MatchDetailsEndpointRelationship
  }

instance ToJSON MatchDetailsEndpointData where
  toJSON MatchDetailsEndpointData{..} = object [ "data" .= endpointData
                                               , "relationships" .= object ["participants" .= endpointRelationships]
                                               ]

matchDetailsEndpoint :: Int -> Connection -> Handler MatchDetailsEndpointData
matchDetailsEndpoint matchId connection = do
  matches <- liftIO $ loadMatchDetails matchId connection
  case matches of 
    Just m -> return $ createResource m
    _      -> throwError err404

createResource :: (MatchTable, [BotTable]) -> MatchDetailsEndpointData
createResource matchDetails = MatchDetailsEndpointData endpointData relationships
  where 
    endpointData = representMatch $ fst matchDetails
    relationships = MatchDetailsEndpointRelationship $ map representBot (snd matchDetails)
