{-# LANGUAGE RecordWildCards   #-}
{-# LANGUAGE OverloadedStrings #-}
module MmoaigAPIWeb.Representers.RockPaperScissorsRoundRepresenter (createRockPaperScissorsRoundIdentifier, createRockPaperScissorsRoundObject, RockPaperScissorsRoundAttributes) where

import Data.Aeson (ToJSON, toJSON, FromJSON, parseJSON, object, (.=), withObject, (.:))
import Data.Time (LocalTime)

import MmoaigAPI.Schema (dbRockPaperScissorsRoundCreatedAt, dbRockPaperScissorsRoundUpdatedAt, dbRockPaperScissorsMatchInstanceId, PrimaryKey(MatchParticipationTableId, MatchInstanceTableId), dbRockPaperScissorsRoundWinner, DBRockPaperScissorsThrow(DBRockPaperScissorsRock, DBRockPaperScissorsPaper, DBRockPaperScissorsScissors), dbRockPaperScissorsRoundId, dbRockPaperScissorsRoundNumber, dbRockPaperScissorsFirstPlayerThrow, dbRockPaperScissorsSecondPlayerThrow, RockPaperScissorsRoundTable, RockPaperScissorsRoundTableT(RockPaperScissorsRoundTable), dbRockPaperScissorsRoundId)
import MmoaigAPIWeb.Representers.JSONApi(ResourceIdentifier(ResourceIdentifier), ResourceObject(ResourceObject))

data MatchAttributesThrow = RockPaperScissorsRock
                          | RockPaperScissorsPaper
                          | RockPaperScissorsScissors
                          deriving (Show, Eq)

-- TODO Test this
instance ToJSON MatchAttributesThrow where
    toJSON RockPaperScissorsRock     = "RockPaperScissorsRock"
    toJSON RockPaperScissorsPaper    = "RockPaperScissorsPaper"
    toJSON RockPaperScissorsScissors = "RockPaperScissorsScissors"

-- TODO Test this
instance FromJSON MatchAttributesThrow where
    parseJSON "RockPaperScissorsRock"     = pure RockPaperScissorsRock
    parseJSON "RockPaperScissorsPaper"    = pure RockPaperScissorsPaper
    parseJSON "RockPaperScissorsScissors" = pure RockPaperScissorsScissors
    parseJSON _                           = fail "oops"

data RockPaperScissorsRoundAttributes = RockPaperScissorsRoundAttributes
  { rockPaperScissorsRoundNumber            :: Int
  , rockPaperScissorsRoundFirstPlayerThrow  :: MatchAttributesThrow
  , rockPaperScissorsRoundSecondPlayerThrow :: MatchAttributesThrow
  , rockPaperScissorsRoundWinnerId          :: Int
  , rockPaperScissorsRoundMatchInstanceId   :: Int
  , rockPaperScissorsRoundCreatedAt         :: LocalTime
  , rockPaperScissorsRoundUpdatedAt         :: LocalTime
  }

-- TODO: Test this
instance ToJSON RockPaperScissorsRoundAttributes where
  toJSON RockPaperScissorsRoundAttributes{..} = object [ "roundNumber"       .= rockPaperScissorsRoundNumber
                                                       , "firstPlayerThrow"  .= rockPaperScissorsRoundFirstPlayerThrow
                                                       , "secondPlayerThrow" .= rockPaperScissorsRoundSecondPlayerThrow
                                                       , "roundWinnerId"     .= rockPaperScissorsRoundWinnerId
                                                       , "matchInstanceId"   .= rockPaperScissorsRoundMatchInstanceId
                                                       , "createdAt"         .= rockPaperScissorsRoundCreatedAt
                                                       , "updatedAt"         .= rockPaperScissorsRoundUpdatedAt
                                                       ]

-- TODO: Test this
instance FromJSON RockPaperScissorsRoundAttributes where
  parseJSON = withObject "RockPaperScissorsRoundAttributes" $ \o -> do
    rockPaperScissorsRoundNumber            <- o .: "roundNumber"
    rockPaperScissorsRoundFirstPlayerThrow  <- o .: "firstPlayerThrow"
    rockPaperScissorsRoundSecondPlayerThrow <- o .: "secondPlayerThrow"
    rockPaperScissorsRoundMatchInstanceId   <- o .: "matchInstanceId"
    rockPaperScissorsRoundWinnerId          <- o .: "roundWinnerId"
    rockPaperScissorsRoundCreatedAt         <- o .: "createdAt"
    rockPaperScissorsRoundUpdatedAt         <- o .: "updatedAt"
    return RockPaperScissorsRoundAttributes{..}

-- TODO: Test this
createRockPaperScissorsRoundIdentifier :: RockPaperScissorsRoundTable -> ResourceIdentifier
createRockPaperScissorsRoundIdentifier RockPaperScissorsRoundTable{..} = ResourceIdentifier dbRockPaperScissorsRoundId "rock_paper_scissors_rounds"

-- TODO: Test this
createRockPaperScissorsRoundObject :: RockPaperScissorsRoundTable -> ResourceObject RockPaperScissorsRoundAttributes ()
createRockPaperScissorsRoundObject roundInstance@RockPaperScissorsRoundTable{..} = ResourceObject identifier (Just attributes) Nothing
  where
    attributes = RockPaperScissorsRoundAttributes  dbRockPaperScissorsRoundNumber (representThrow dbRockPaperScissorsFirstPlayerThrow) (representThrow dbRockPaperScissorsSecondPlayerThrow) winnerId instanceId dbRockPaperScissorsRoundCreatedAt dbRockPaperScissorsRoundUpdatedAt
    identifier = createRockPaperScissorsRoundIdentifier roundInstance
    (MatchParticipationTableId winnerId) = dbRockPaperScissorsRoundWinner
    (MatchInstanceTableId instanceId) = dbRockPaperScissorsMatchInstanceId

-- TODO Test this
representThrow :: DBRockPaperScissorsThrow -> MatchAttributesThrow
representThrow DBRockPaperScissorsRock     = RockPaperScissorsRock
representThrow DBRockPaperScissorsPaper    = RockPaperScissorsPaper
representThrow DBRockPaperScissorsScissors = RockPaperScissorsScissors