module MmoaigAPIWeb.MatchParticipationListEndpoint (matchParticipationListEndpoint, MatchParticipationListEndpointData) where

import Database.PostgreSQL.Simple (Connection)
import Servant (Handler)
import Control.Monad.IO.Class (liftIO)

import MmoaigAPIWeb.Representers.JSONApi (JSONAPIResponse(SuccessResponse), PrimaryData(ResourceObjects))
import MmoaigAPI.MatchParticipation (loadMatchParticipation)
import MmoaigAPIWeb.Representers.MatchParticipationRepresenter (MatchParticipationAttributes, createMatchParticipationObject)

type MatchParticipationListEndpointData = JSONAPIResponse MatchParticipationAttributes ()

matchParticipationListEndpoint :: Maybe Int -> Connection -> Handler MatchParticipationListEndpointData
matchParticipationListEndpoint matchIdFilter connection = do
  matchParticipation <- liftIO $ loadMatchParticipation matchIdFilter connection
  return $ SuccessResponse $ ResourceObjects $ map createMatchParticipationObject matchParticipation
