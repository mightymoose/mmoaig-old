{-# LANGUAGE RecordWildCards   #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveGeneric     #-}
module MmoaigAPIWeb.Representers.MatchRepresenter (representMatch, representMatchAttributes, MatchAttributes, MatchRelationships) where

import Data.Aeson (ToJSON, toJSON, object, (.=))
import GHC.Generics (Generic)

import MmoaigAPIWeb.Representers.APIResponse (ResourceIdentifier(ResourceIdentifierWithRelationships))
import MmoaigAPIWeb.Representers.BotRepresenter (BotAttributes, representBot)
import MmoaigAPI.Schema ( MatchTable
                        , BotTable
                        , MatchTableT(MatchTable)
                        , DBMatchStatus(DBMatchPending, DBMatchInProgress, DBMatchComplete, DBMatchCancelled)
                        , DBMatchType(DBRockPaperScissorsMatch)
                        , dbMatchId
                        , dbMatchStatus
                        , dbMatchType
                       )

data MatchAttributesStatus = MatchPending
                           | MatchInProgress
                           | MatchComplete
                           | MatchCancelled
                           deriving (Show, Generic)

instance ToJSON MatchAttributesStatus

data MatchAttributesType = RockPaperScissors
                         deriving (Show, Generic)

instance ToJSON MatchAttributesType where
  toJSON RockPaperScissors = "RockPaperScissors"

data MatchAttributes = MatchAttributes MatchAttributesStatus MatchAttributesType

data MatchRelationships = MatchRelationships [ResourceIdentifier BotAttributes ()]

instance ToJSON MatchRelationships where
  toJSON (MatchRelationships s) = object [ "participants" .= object ["data" .= s] ]

instance ToJSON MatchAttributes where
  toJSON (MatchAttributes s t) = object [ "status" .= s, "type" .= t ]

representMatchAttributes :: MatchTable -> MatchAttributes
representMatchAttributes MatchTable{..} = MatchAttributes (representMatchStatus dbMatchStatus) (representMatchType dbMatchType)

representMatch :: MatchTable -> [BotTable] -> ResourceIdentifier MatchAttributes MatchRelationships
representMatch match bots = ResourceIdentifierWithRelationships (dbMatchId match) "matches" attributes relationships
  where
    attributes = representMatchAttributes match
    relationships = representMatchBots bots 

representMatchStatus :: DBMatchStatus -> MatchAttributesStatus
representMatchStatus DBMatchPending    = MatchPending
representMatchStatus DBMatchInProgress = MatchInProgress
representMatchStatus DBMatchComplete   = MatchComplete
representMatchStatus DBMatchCancelled  = MatchCancelled

representMatchType :: DBMatchType -> MatchAttributesType
representMatchType DBRockPaperScissorsMatch = RockPaperScissors

representMatchBots :: [BotTable] -> MatchRelationships
representMatchBots bots = MatchRelationships $ map representBot bots
