{-# LANGUAGE RecordWildCards   #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveGeneric     #-}
module MmoaigAPIWeb.Representers.MatchRepresenter (representMatch, MatchAttributes) where

import Data.Aeson (ToJSON, toJSON, object, (.=))
import GHC.Generics (Generic)

import MmoaigAPIWeb.Representers.APIResponse (ResourceIdentifier(ResourceIdentifier))
import MmoaigAPI.Schema ( MatchTable
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

instance ToJSON MatchAttributes where
  toJSON (MatchAttributes s t) = object [ "status" .= s, "type" .= t ]

representMatch :: MatchTable -> ResourceIdentifier MatchAttributes ()
representMatch MatchTable{..} = ResourceIdentifier dbMatchId "matches" attributes
  where
    attributes = MatchAttributes (representMatchStatus dbMatchStatus) (representMatchType dbMatchType)

representMatchStatus :: DBMatchStatus -> MatchAttributesStatus
representMatchStatus DBMatchPending    = MatchPending
representMatchStatus DBMatchInProgress = MatchInProgress
representMatchStatus DBMatchComplete   = MatchComplete
representMatchStatus DBMatchCancelled  = MatchCancelled

representMatchType :: DBMatchType -> MatchAttributesType
representMatchType DBRockPaperScissorsMatch = RockPaperScissors
