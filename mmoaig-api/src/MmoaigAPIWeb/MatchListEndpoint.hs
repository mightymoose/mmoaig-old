module MmoaigAPIWeb.MatchListEndpoint (matchListEndpoint, MatchListEndpointData) where

import Servant (Handler)
import Control.Monad.IO.Class (liftIO)
import Database.PostgreSQL.Simple (Connection)

import MmoaigAPI.Matches (loadMatchList)
import MmoaigAPIWeb.Representers.MatchRepresenter (MatchAttributes, createMatchObject, MatchRelationships)

import MmoaigAPIWeb.Representers.JSONApi (JSONAPIResponse(SuccessResponse), PrimaryData(ResourceObjects))

type MatchListEndpointData = JSONAPIResponse MatchAttributes MatchRelationships

matchListEndpoint :: Connection -> Handler MatchListEndpointData
matchListEndpoint connection = do
  matches <- liftIO $ loadMatchList connection
  return $ SuccessResponse $ ResourceObjects $ map (`createMatchObject` Nothing) matches

