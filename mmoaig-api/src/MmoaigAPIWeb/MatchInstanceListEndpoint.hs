module MmoaigAPIWeb.MatchInstanceListEndpoint (MatchInstanceListEndpointData, matchInstanceListEndpoint) where

import Servant (Handler)
import Control.Monad.IO.Class (liftIO)
import Database.PostgreSQL.Simple (Connection)

import MmoaigAPIWeb.Representers.JSONApi (JSONAPIResponse(SuccessResponse), PrimaryData(ResourceObjects))

import MmoaigAPIWeb.Representers.MatchInstanceRepresenter (createMatchInstanceObject, MatchInstanceAttributes)

import MmoaigAPI.MatchInstances (loadMatchInstanceList)

type MatchInstanceListEndpointData = JSONAPIResponse MatchInstanceAttributes ()

matchInstanceListEndpoint :: Connection -> Handler MatchInstanceListEndpointData
matchInstanceListEndpoint connection = do
  matchInstances <- liftIO $ loadMatchInstanceList connection
  return $ SuccessResponse $ ResourceObjects $ map createMatchInstanceObject matchInstances
