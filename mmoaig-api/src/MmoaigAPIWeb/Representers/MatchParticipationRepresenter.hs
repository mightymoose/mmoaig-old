{-# LANGUAGE RecordWildCards   #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE FlexibleInstances #-}
module MmoaigAPIWeb.Representers.MatchParticipationRepresenter (createMatchParticipationIdentifier, createMatchParticipationObject, MatchParticipationAttributes) where

import Data.Aeson (ToJSON, toJSON, FromJSON, parseJSON, object, (.=), withObject, (.:))
import Data.Time (LocalTime)

import MmoaigAPI.Schema (MatchParticipationTable, MatchParticipationTableT(MatchParticipationTable), dbMatchParticipationId, dbMatchParticipationBotId, dbMatchParticipationMatchId, PrimaryKey(BotTableId, MatchTableId), dbMatchParticipationCreatedAt, dbMatchParticipationUpdatedAt)
import MmoaigAPIWeb.Representers.JSONApi(ResourceIdentifier(ResourceIdentifier), ResourceObject(ResourceObject))

data MatchParticipationAttributes = MatchParticipationAttributes
  { matchParticipationBotId     :: Int
  , matchParticipationMatchId   :: Int
  , matchParticipationCreatedAt :: LocalTime
  , matchParticipationUpdatedAt :: LocalTime
  }

-- TODO: Test this
instance ToJSON MatchParticipationAttributes where
  toJSON MatchParticipationAttributes{..} = object [ "matchId"   .= matchParticipationMatchId
                                                   , "botId"     .= matchParticipationBotId
                                                   , "createdAt" .= matchParticipationCreatedAt
                                                   , "updatedAt" .= matchParticipationUpdatedAt
                                                   ]

-- TODO: Test this
instance FromJSON MatchParticipationAttributes where
  parseJSON = withObject "MatchParticipationAttributes" $ \o -> do
    matchParticipationBotId     <- o .: "botId"
    matchParticipationMatchId   <- o .: "matchId"
    matchParticipationCreatedAt <- o .: "createdAt"
    matchParticipationUpdatedAt <- o .: "updatedAt"
    return MatchParticipationAttributes{..}

-- TODO: Test this
createMatchParticipationIdentifier :: MatchParticipationTable -> ResourceIdentifier
createMatchParticipationIdentifier MatchParticipationTable{..} = ResourceIdentifier dbMatchParticipationId "match_participation"

-- TODO: Test this
createMatchParticipationObject :: MatchParticipationTable -> ResourceObject MatchParticipationAttributes ()
createMatchParticipationObject matchParticipation@MatchParticipationTable{..} = ResourceObject identifier (Just attributes) Nothing
  where
    attributes = MatchParticipationAttributes botId matchId dbMatchParticipationCreatedAt dbMatchParticipationUpdatedAt
    identifier = createMatchParticipationIdentifier matchParticipation
    (BotTableId botId) = dbMatchParticipationBotId
    (MatchTableId matchId) = dbMatchParticipationMatchId
