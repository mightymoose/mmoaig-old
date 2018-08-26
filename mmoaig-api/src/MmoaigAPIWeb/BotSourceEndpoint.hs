module MmoaigAPIWeb.BotSourceEndpoint (botSourceEndpoint) where

import Database.PostgreSQL.Simple (Connection)
import Servant (Handler)
import Control.Monad.IO.Class (liftIO)

import MmoaigAPI.Bots (loadBotSource)

botSourceEndpoint :: Int -> Connection -> Handler String
botSourceEndpoint botId = liftIO . loadBotSource botId
