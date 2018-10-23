module MmoaigAPIWeb.MatchDetailsEndpoint (matchDetailsEndpoint, MatchDetailsEndpointData) where

import Servant (Handler, err404, throwError)
import Control.Monad.IO.Class (liftIO)
import Database.PostgreSQL.Simple (Connection)

import MmoaigAPI.Matches (loadMatchDetails)

import MmoaigAPIWeb.Representers.JSONApi (JSONAPIResponse(SuccessResponse), PrimaryData(SingleResourceObject, ResourceObjects))
import MmoaigAPIWeb.Representers.MatchRepresenter (createMatchObject, MatchAttributes, MatchRelationships(MatchRelationships))
import MmoaigAPIWeb.Representers.BotRepresenter (createBotObject)

type MatchDetailsEndpointData = JSONAPIResponse MatchAttributes MatchRelationships

-- TODO: Move the MatchRelationships creation into the representer
matchDetailsEndpoint :: Int -> Connection -> Handler MatchDetailsEndpointData
matchDetailsEndpoint matchId connection = do
  matches <- liftIO $ loadMatchDetails matchId connection
  case matches of 
    Just (m, b) -> return $ SuccessResponse $ SingleResourceObject $ createMatchObject m (Just (MatchRelationships (SuccessResponse (ResourceObjects (map createBotObject b)))))
    _           -> throwError err404
