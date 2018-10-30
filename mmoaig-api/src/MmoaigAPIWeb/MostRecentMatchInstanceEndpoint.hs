module MmoaigAPIWeb.MostRecentMatchInstanceEndpoint (mostRecentInstanceForMatchEndpoint, MostRecentInstanceForMatchEndpointData) where

import Servant (Handler, err404, throwError)
import Control.Monad.IO.Class (liftIO)
import Database.PostgreSQL.Simple (Connection)
    
import MmoaigAPI.MatchInstances (mostRecentInstanceForMatch)
    
import MmoaigAPIWeb.Representers.JSONApi (JSONAPIResponse(SuccessResponse), PrimaryData(SingleResourceObject))
    
import MmoaigAPIWeb.Representers.MatchInstanceRepresenter (MatchInstanceAttributes, createMatchInstanceObject)
    
type MostRecentInstanceForMatchEndpointData = JSONAPIResponse MatchInstanceAttributes ()
    
-- TODO: Write tests for this
mostRecentInstanceForMatchEndpoint :: Int -> Connection -> Handler MostRecentInstanceForMatchEndpointData
mostRecentInstanceForMatchEndpoint matchId connection = do
  i <- liftIO $ mostRecentInstanceForMatch matchId connection
  case i of 
    Just m -> return $ SuccessResponse $ SingleResourceObject $ createMatchInstanceObject m
    _      -> throwError err404
    