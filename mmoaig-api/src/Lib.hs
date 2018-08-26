{-# LANGUAGE DataKinds             #-}
{-# LANGUAGE TemplateHaskell       #-}
{-# LANGUAGE TypeOperators         #-}
{-# LANGUAGE FlexibleInstances     #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE OverloadedStrings     #-}
module Lib
    ( startApp
    , app
    , api
    , server
    ) where

import Network.Wai
import Network.Wai.Handler.Warp
import Servant
import Data.Pool (withResource, Pool)
import Database.PostgreSQL.Simple (Connection)
import Data.ByteString.Lazy.Char8 (pack)

import System.Environment (getEnvironment)

import MmoaigAPIWeb.BotListEndpoint (botListEndpoint)
import MmoaigAPIWeb.UserListEndpoint (userListEndpoint, UserListEndpointData)
import MmoaigAPIWeb.UpdateMatchEndpoint (UpdateMatchEndpointData, updateMatchEndpoint)
import MmoaigAPIWeb.MatchListEndpoint (matchListEndpoint)
import MmoaigAPIWeb.MatchDetailsEndpoint (matchDetailsEndpoint, MatchDetailsEndpointData)
import MmoaigAPIWeb.NextMatchEndpoint (nextMatchEndpoint, NextMatchEndpointData)
import MmoaigAPIWeb.GithubUserListEndpoint (githubUserListEndpoint, GithubUserListEndpointData)
import MmoaigAPIWeb.GithubRepositoryListEndpoint (githubRepositoryListEndpoint, GithubRepositoryListEndpointData)
import MmoaigAPIWeb.BotSourceEndpoint (botSourceEndpoint)
import MmoaigAPI.Environment (createEnvironment)
import MmoaigAPI.Configuration (createConfiguration, Configuration, createConnectInfo, databaseConnectionPool)
import Network.HTTP.Media ((//), (/:))
import Data.Typeable (Typeable)

import MmoaigAPIWeb.Representers.APIResponse (APIResponse)
import MmoaigAPIWeb.Representers.BotRepresenter (BotAttributes)
import MmoaigAPIWeb.Representers.MatchRepresenter (MatchAttributes)

data Javascript deriving Typeable

instance Accept Javascript where
  contentType _ = "application" // "javascript" /: ("charset", "utf-8")

instance MimeRender Javascript String where
   mimeRender _ = pack

type API = "v1" :> ( "users" :> Get '[JSON] UserListEndpointData
                :<|> "github-repositories"                                                         :> Get '[JSON] GithubRepositoryListEndpointData
                :<|> "github-users"                                                                :> Get '[JSON] GithubUserListEndpointData
                :<|> "bots"                                                                        :> Get '[JSON] (APIResponse BotAttributes)
                :<|> "bots" :> Capture "botId" Int :> "source"                                     :> Get '[Javascript] String
                :<|> "matches"                                                                     :> Get '[JSON] (APIResponse MatchAttributes)
                :<|> "matches" :> "next"                                                           :> Get '[JSON] NextMatchEndpointData
                :<|> "matches" :> Capture "matchId" Int                                            :> Get '[JSON] MatchDetailsEndpointData
                :<|> "matches" :> Capture "matchId" Int :> ReqBody '[JSON] UpdateMatchEndpointData :> Put '[JSON] UpdateMatchEndpointData
                )

startApp :: IO ()
startApp = do
  environment <- createEnvironment <$> getEnvironment
  case environment of
    Just env -> do
      config <- createConfiguration $ createConnectInfo env
      run 8080 $ app config
    Nothing -> putStrLn "Could not initialize app."

app :: Configuration -> Application
app configuration = serve api $ server pool
  where
    pool = databaseConnectionPool configuration

api :: Proxy API
api = Proxy

server :: Pool Connection -> Server API
server pool = (        withResource pool userListEndpoint             )
         :<|> (        withResource pool githubRepositoryListEndpoint )
         :<|> (        withResource pool githubUserListEndpoint       )
         :<|> (        withResource pool botListEndpoint              )
         :<|> (\i   -> withResource pool (botSourceEndpoint i)        )
         :<|> (        withResource pool matchListEndpoint            )
         :<|> (        withResource pool nextMatchEndpoint            )
         :<|> (\i   -> withResource pool (matchDetailsEndpoint i)     )
         :<|> (\i j -> withResource pool (updateMatchEndpoint i j)    )
