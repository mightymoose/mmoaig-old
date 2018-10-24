module MmoaigAPIWeb.RockPaperScissorsRoundListEndpoint (rockPaperScissorsRoundListEndpoint, RockPaperScissorsRoundListEndpointData) where

import Servant (Handler)
import Control.Monad.IO.Class (liftIO)
import Database.PostgreSQL.Simple (Connection)
    
import MmoaigAPI.RockPaperScissorsRounds (loadRockPaperScissorsRoundList)
import MmoaigAPIWeb.Representers.RockPaperScissorsRoundRepresenter (RockPaperScissorsRoundAttributes, createRockPaperScissorsRoundObject)
    
import MmoaigAPIWeb.Representers.JSONApi (JSONAPIResponse(SuccessResponse), PrimaryData(ResourceObjects))
    
type RockPaperScissorsRoundListEndpointData = JSONAPIResponse RockPaperScissorsRoundAttributes ()
    
rockPaperScissorsRoundListEndpoint :: Connection -> Handler RockPaperScissorsRoundListEndpointData
rockPaperScissorsRoundListEndpoint connection = do
  rounds <- liftIO $ loadRockPaperScissorsRoundList connection
  return $ SuccessResponse $ ResourceObjects $ map createRockPaperScissorsRoundObject rounds
    
    