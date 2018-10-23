module MmoaigAPIWeb.BotListEndpoint (botListEndpoint, BotListEndpointData) where

import Servant (Handler)
import Control.Monad.IO.Class (liftIO)
import Database.PostgreSQL.Simple (Connection)

import MmoaigAPI.Bots (loadBotList)

import MmoaigAPIWeb.Representers.JSONApi (JSONAPIResponse(SuccessResponse), PrimaryData(ResourceObjects))
import MmoaigAPIWeb.Representers.BotRepresenter (BotAttributes, createBotObject)

type BotListEndpointData = JSONAPIResponse BotAttributes ()

botListEndpoint :: Connection -> Handler BotListEndpointData
botListEndpoint connection = do
  bots <- liftIO $ loadBotList connection
  return $ SuccessResponse $ ResourceObjects $ map createBotObject bots
