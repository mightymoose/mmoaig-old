module MmoaigAPIWeb.MatchListEndpoint (matchListEndpoint) where

import Servant (Handler)
import Control.Monad.IO.Class (liftIO)
import Database.PostgreSQL.Simple (Connection)

import MmoaigAPI.Matches (loadMatchList)
import MmoaigAPIWeb.Representers.MatchRepresenter (MatchAttributes, representMatch)
import MmoaigAPIWeb.Representers.APIResponse (APIResponse(APIResponse))

matchListEndpoint :: Connection -> Handler (APIResponse MatchAttributes)
matchListEndpoint connection = do
  matches <- liftIO $ loadMatchList connection
  return $ APIResponse $ map representMatch matches

