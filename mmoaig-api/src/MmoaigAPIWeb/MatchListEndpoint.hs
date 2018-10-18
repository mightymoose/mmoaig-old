module MmoaigAPIWeb.MatchListEndpoint (matchListEndpoint) where

import Servant (Handler)
import Control.Monad.IO.Class (liftIO)
import Database.PostgreSQL.Simple (Connection)

import MmoaigAPI.Matches (loadMatchList)
import MmoaigAPI.Schema (MatchTable, dbMatchId)
import MmoaigAPIWeb.Representers.MatchRepresenter (MatchAttributes, representMatchAttributes)
import MmoaigAPIWeb.Representers.APIResponse (APIResponse(APIResponse), ResourceIdentifier(ResourceIdentifier))

matchListEndpoint :: Connection -> Handler (APIResponse MatchAttributes)
matchListEndpoint connection = do
  matches <- liftIO $ loadMatchList connection
  return $ APIResponse $  map buildResponse matches

buildResponse :: MatchTable -> ResourceIdentifier MatchAttributes ()
buildResponse match = ResourceIdentifier (dbMatchId match) "matches" attributes
  where
    attributes = representMatchAttributes match
