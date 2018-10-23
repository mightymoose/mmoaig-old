module MmoaigAPIWeb.NextMatchEndpoint (nextMatchEndpoint, NextMatchEndpointData) where

import Servant (Handler, err404, throwError)
import Control.Monad.IO.Class (liftIO)
import Database.PostgreSQL.Simple (Connection)

import MmoaigAPI.Matches (loadNextMatch)

import MmoaigAPIWeb.Representers.JSONApi (JSONAPIResponse(SuccessResponse), PrimaryData(SingleResourceObject))

import MmoaigAPIWeb.Representers.MatchRepresenter (createMatchObject, MatchAttributes, MatchRelationships)

type NextMatchEndpointData = JSONAPIResponse MatchAttributes MatchRelationships

nextMatchEndpoint ::  Connection -> Handler NextMatchEndpointData
nextMatchEndpoint connection = do
  matches <- liftIO $ loadNextMatch connection
  case matches of 
    Just (m, _, _) -> return $ SuccessResponse $ SingleResourceObject $ createMatchObject m Nothing
    _      -> throwError err404
