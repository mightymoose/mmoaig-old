{-# LANGUAGE RecordWildCards   #-}
{-# LANGUAGE OverloadedStrings #-}
module MmoaigAPIWeb.Representers.MatchRepresenter (MatchRelationships(MatchRelationships), createMatchIdentifier, createMatchObject, MatchAttributes) where

import Control.Monad (fail)
import Data.Aeson (ToJSON, toJSON, FromJSON, parseJSON, object, (.=), withObject, (.:))

import MmoaigAPI.Schema (MatchTable, MatchTableT(MatchTable), dbMatchId, DBMatchStatus(DBMatchPending, DBMatchInProgress, DBMatchComplete, DBMatchCancelled), DBMatchType(DBRockPaperScissorsMatch), dbMatchStatus, dbMatchType)
import MmoaigAPIWeb.Representers.JSONApi (JSONAPIResponse, ResourceIdentifier(ResourceIdentifier), ResourceObject(ResourceObject))
import MmoaigAPIWeb.Representers.BotRepresenter (BotAttributes)

data MatchAttributesStatus = MatchPending
                           | MatchInProgress
                           | MatchComplete
                           | MatchCancelled
                           deriving (Show, Eq)

-- TODO Test this
instance ToJSON MatchAttributesStatus where
  toJSON MatchPending    = "MatchPending"
  toJSON MatchInProgress = "MatchInProgress"
  toJSON MatchComplete   = "MatchComplete"
  toJSON MatchCancelled  = "MatchCancelled"

-- TODO Test this
instance FromJSON MatchAttributesStatus where
  parseJSON "MatchPending"    = pure MatchPending
  parseJSON "MatchInProgress" = pure MatchInProgress
  parseJSON "MatchComplete"   = pure MatchComplete
  parseJSON "MatchCancelled"  = pure MatchCancelled
  parseJSON _                 = fail "oops"

-- TODO Test this
data MatchAttributesType = RockPaperScissors
                         deriving (Show, Eq)

newtype MatchRelationships = MatchRelationships
  { matchParticipants :: JSONAPIResponse BotAttributes ()
  }

-- TODO: Test this
instance ToJSON MatchRelationships where
  toJSON MatchRelationships{..} = object [ "participants" .= matchParticipants ] 

-- TODO Test this
instance FromJSON MatchAttributesType where
  parseJSON "RockPaperScissors" = pure RockPaperScissors
  parseJSON _                   = fail "oops"

-- TODO Test this
representMatchStatus :: DBMatchStatus -> MatchAttributesStatus
representMatchStatus DBMatchPending    = MatchPending
representMatchStatus DBMatchInProgress = MatchInProgress
representMatchStatus DBMatchComplete   = MatchComplete
representMatchStatus DBMatchCancelled  = MatchCancelled

-- TODO Test this
representMatchType :: DBMatchType -> MatchAttributesType
representMatchType DBRockPaperScissorsMatch = RockPaperScissors

instance ToJSON MatchAttributesType where
  toJSON RockPaperScissors = "RockPaperScissors"

data MatchAttributes = MatchAttributes 
  { matchType   :: MatchAttributesType
  , matchStatus :: MatchAttributesStatus
  }

-- TODO: Test this
instance ToJSON MatchAttributes where
  toJSON MatchAttributes{..} = object [ "type" .= matchType, "status" .= matchStatus ] 

-- TODO: Test this
instance FromJSON MatchAttributes where
  parseJSON = withObject "MatchAttributes" $ \o -> do
    matchType   <- o .: "type"
    matchStatus <- o .: "status"
    return MatchAttributes{..}

-- TODO: Test this
createMatchIdentifier :: MatchTable -> ResourceIdentifier
createMatchIdentifier MatchTable{..} = ResourceIdentifier dbMatchId "matches"

-- TODO: Test this
-- TODO: Fix this so that it does not use JSONApiResponse, but instead a properly built Relationships object
createMatchObject :: MatchTable -> Maybe MatchRelationships -> ResourceObject MatchAttributes MatchRelationships
createMatchObject match@MatchTable{..} = ResourceObject identifier (Just attributes)
  where
    attributes = MatchAttributes (representMatchType dbMatchType) (representMatchStatus dbMatchStatus)
    identifier = createMatchIdentifier match
