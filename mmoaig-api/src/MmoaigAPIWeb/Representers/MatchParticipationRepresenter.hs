{-# LANGUAGE RecordWildCards   #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE FlexibleInstances #-}
module MmoaigAPIWeb.Representers.MatchParticipationRepresenter (createMatchParticipationIdentifier, createMatchParticipationObject, MatchParticipationAttributes) where

import Data.Aeson (ToJSON, toJSON, FromJSON, parseJSON, object, (.=), withObject, (.:))

import MmoaigAPI.Schema (MatchParticipationTable, MatchParticipationTableT(MatchParticipationTable), dbMatchParticipationId, dbMatchParticipationBotId, dbMatchParticipationMatchId, PrimaryKey(BotTableId, MatchTableId))
import MmoaigAPIWeb.Representers.JSONApi(ResourceIdentifier(ResourceIdentifier), ResourceObject(ResourceObject))

data MatchParticipationAttributes = MatchParticipationAttributes
  { matchParticipationBotId   :: Int
  , matchParticipationMatchId :: Int
  }

-- TODO: Test this
instance ToJSON MatchParticipationAttributes where
  toJSON MatchParticipationAttributes{..} = object [ "matchId" .= matchParticipationMatchId
                                                   , "botId"   .= matchParticipationBotId
                                                   ]

-- TODO: Test this
instance FromJSON MatchParticipationAttributes where
  parseJSON = withObject "MatchParticipationAttributes" $ \o -> do
    matchParticipationBotId   <- o .: "botId"
    matchParticipationMatchId <- o .: "matchId"
    return MatchParticipationAttributes{..}

-- TODO: Test this
createMatchParticipationIdentifier :: MatchParticipationTable -> ResourceIdentifier
createMatchParticipationIdentifier MatchParticipationTable{..} = ResourceIdentifier dbMatchParticipationId "match_participation"

-- TODO: Test this
createMatchParticipationObject :: MatchParticipationTable -> ResourceObject MatchParticipationAttributes ()
createMatchParticipationObject matchParticipation@MatchParticipationTable{..} = ResourceObject identifier (Just attributes) Nothing
  where
    attributes = MatchParticipationAttributes botId matchId
    identifier = createMatchParticipationIdentifier matchParticipation
    (BotTableId botId) = dbMatchParticipationBotId
    (MatchTableId matchId) = dbMatchParticipationMatchId
