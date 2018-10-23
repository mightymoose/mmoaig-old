module MmoaigAPIWeb.NextMatchEndpoint (nextMatchEndpoint, NextMatchEndpointData) where

import Servant (Handler, err404, throwError)
import Control.Monad.IO.Class (liftIO)
import Database.PostgreSQL.Simple (Connection)

import MmoaigAPI.Matches (loadNextMatch)

import MmoaigAPIWeb.Representers.JSONApi (JSONAPIResponse(SuccessResponse), PrimaryData(SingleResourceObject, ResourceObjects))

import MmoaigAPIWeb.Representers.MatchRepresenter (MatchRelationships(MatchRelationships), createMatchObject, MatchAttributes, MatchRelationships)
import MmoaigAPIWeb.Representers.BotRepresenter (createBotObject)

type NextMatchEndpointData = JSONAPIResponse MatchAttributes MatchRelationships

nextMatchEndpoint ::  Connection -> Handler NextMatchEndpointData
nextMatchEndpoint connection = do
  matches <- liftIO $ loadNextMatch connection
  case matches of 
    Just (m, b, _) -> return $ SuccessResponse $ SingleResourceObject $ createMatchObject m (Just (MatchRelationships (SuccessResponse (ResourceObjects (map createBotObject b)))))
    _      -> throwError err404
