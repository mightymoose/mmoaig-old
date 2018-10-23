{-# LANGUAGE OverloadedStrings #-}
module MmoaigAPIWeb.Games.CreateRockPaperScissorsRoundEndpoint (createRockPaperScissorsRoundEndpoint, CreateRockPaperScissorsRoundEndpointData) where

import Servant (Handler)
import Data.Aeson (ToJSON, toJSON)

data CreateRockPaperScissorsRoundEndpointData = RockPaperScissorsMatchComplete

instance ToJSON CreateRockPaperScissorsRoundEndpointData where
  toJSON RockPaperScissorsMatchComplete = "RockPaperScissorsMatchComplete"

createRockPaperScissorsRoundEndpoint :: Handler CreateRockPaperScissorsRoundEndpointData
createRockPaperScissorsRoundEndpoint = return RockPaperScissorsMatchComplete