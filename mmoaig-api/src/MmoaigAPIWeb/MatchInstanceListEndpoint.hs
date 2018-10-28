module MmoaigAPIWeb.MatchInstanceListEndpoint ( MatchInstanceListEndpointData
                                              , matchInstanceListEndpoint) where

import Servant (Handler)
import Control.Monad.IO.Class (liftIO)
import Database.PostgreSQL.Simple (Connection)

import MmoaigAPIWeb.Representers.JSONApi (JSONAPIResponse(SuccessResponse), PrimaryData(ResourceObjects))

import MmoaigAPIWeb.Representers.MatchInstanceRepresenter (createMatchInstanceObject, MatchInstanceAttributes)

import MmoaigAPI.MatchInstances (loadMatchInstanceList)

type MatchInstanceListEndpointData = JSONAPIResponse MatchInstanceAttributes ()

matchInstanceListEndpoint :: Maybe Int -> Connection -> Handler MatchInstanceListEndpointData
matchInstanceListEndpoint matchIdFilter connection = do
  matchInstances <- liftIO $ loadMatchInstanceList matchIdFilter connection
  return $ SuccessResponse $ ResourceObjects $ map createMatchInstanceObject matchInstances
