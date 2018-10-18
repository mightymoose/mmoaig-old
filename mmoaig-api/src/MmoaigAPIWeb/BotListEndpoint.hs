module MmoaigAPIWeb.BotListEndpoint (botListEndpoint) where

import Servant (Handler)
import Control.Monad.IO.Class (liftIO)
import Database.PostgreSQL.Simple (Connection)

import MmoaigAPI.Bots (loadBotList)

import MmoaigAPIWeb.Representers.BotRepresenter (BotAttributes, representBot)
import MmoaigAPIWeb.Representers.APIResponse (APIResponse(APIResponse))

botListEndpoint :: Connection -> Handler (APIResponse BotAttributes)
botListEndpoint connection = do
  bots <- liftIO $ loadBotList connection
  return $ APIResponse $ map representBot bots
