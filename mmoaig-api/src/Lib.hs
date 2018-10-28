{-# LANGUAGE DataKinds             #-}
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

import MmoaigAPIWeb.BotListEndpoint (botListEndpoint, BotListEndpointData)
import MmoaigAPIWeb.UserListEndpoint (userListEndpoint, UserListEndpointData)
import MmoaigAPIWeb.UpdateMatchEndpoint (UpdateMatchEndpointData, updateMatchEndpoint)
import MmoaigAPIWeb.MatchListEndpoint (matchListEndpoint, MatchListEndpointData)
import MmoaigAPIWeb.RockPaperScissorsRoundListEndpoint (rockPaperScissorsRoundListEndpoint, RockPaperScissorsRoundListEndpointData)
import MmoaigAPIWeb.MatchInstanceListEndpoint (matchInstanceListEndpoint, MatchInstanceListEndpointData)
import MmoaigAPIWeb.MatchDetailsEndpoint (matchDetailsEndpoint, MatchDetailsEndpointData)
import MmoaigAPIWeb.MatchParticipationListEndpoint (matchParticipationListEndpoint, MatchParticipationListEndpointData)
import MmoaigAPIWeb.NextMatchEndpoint (nextMatchEndpoint, NextMatchEndpointData)
import MmoaigAPIWeb.GithubUserListEndpoint (githubUserListEndpoint, GithubUserListEndpointData)
import MmoaigAPIWeb.GithubRepositoryListEndpoint (githubRepositoryListEndpoint, GithubRepositoryListEndpointData)
import MmoaigAPIWeb.Games.CreateRockPaperScissorsRoundEndpoint (createRockPaperScissorsRoundEndpoint, CreateRockPaperScissorsRoundEndpointData)
import MmoaigAPIWeb.BotSourceEndpoint (botSourceEndpoint)
import MmoaigAPIWeb.AuthorizationEndpoint (authorizationEndpoint)
import MmoaigAPI.Environment (createEnvironment)
import MmoaigAPI.Configuration (createConfiguration, Configuration, databaseConnectionPool, secretKey)
import Network.HTTP.Media ((//), (/:))
import Data.Typeable (Typeable)

data Javascript deriving Typeable

instance Accept Javascript where
  contentType _ = "application" // "javascript" /: ("charset", "utf-8")

instance MimeRender Javascript String where
   mimeRender _ = pack

type API = "v1" :> ( "users" :> Get '[JSON] UserListEndpointData
                :<|> "github-repositories"                                                         :> Get '[JSON] GithubRepositoryListEndpointData
                :<|> "github-users"                                                                :> Get '[JSON] GithubUserListEndpointData
                :<|> "bots"                                                                        :> Get '[JSON] BotListEndpointData
                :<|> "bots" :> Capture "botId" Int :> "source"                                     :> Get '[Javascript] String
                :<|> "matches"                                                                     :> Get '[JSON] MatchListEndpointData
                :<|> "matches" :> "next"                                                           :> Get '[JSON] NextMatchEndpointData
                :<|> "matches" :> Capture "matchId" Int                                            :> Get '[JSON] MatchDetailsEndpointData
                :<|> "matches" :> Capture "matchId" Int :> ReqBody '[JSON] UpdateMatchEndpointData :> Put '[JSON] UpdateMatchEndpointData
                :<|> "authorization"                                                               :> Post '[JSON] String
                :<|> "games" :> ( "rock-paper-scissors-round"                                      :> Post '[JSON] CreateRockPaperScissorsRoundEndpointData
                                )
                :<|> "match-instances" :> QueryParam "filter[matchId]" Int                         :> Get '[JSON] MatchInstanceListEndpointData
                :<|> "rock-paper-scissors-rounds"                                                  :> Get '[JSON] RockPaperScissorsRoundListEndpointData
                :<|> "match-participation" :> QueryParam "filter[matchId]" Int                     :> Get '[JSON] MatchParticipationListEndpointData
                )

startApp :: IO ()
startApp = do
  environment <- createEnvironment <$> getEnvironment
  case environment of
    Just env -> do
      config <- createConfiguration env
      run 8080 $ app config 
    Nothing -> putStrLn "Could not initialize app."

app :: Configuration -> Application
app configuration = serve api $ server pool (secretKey configuration)
  where
    pool = databaseConnectionPool configuration

api :: Proxy API
api = Proxy

server :: Pool Connection -> String -> Server API
server pool key = withResource pool userListEndpoint
             :<|> withResource pool githubRepositoryListEndpoint
             :<|> withResource pool githubUserListEndpoint
             :<|> withResource pool botListEndpoint
             :<|> withResource pool . botSourceEndpoint
             :<|> withResource pool matchListEndpoint
             :<|> withResource pool nextMatchEndpoint
             :<|> withResource pool . matchDetailsEndpoint
             :<|> (\i j -> withResource pool (updateMatchEndpoint i j))
             :<|> authorizationEndpoint key
             :<|> createRockPaperScissorsRoundEndpoint
             :<|> withResource pool . matchInstanceListEndpoint
             :<|> withResource pool rockPaperScissorsRoundListEndpoint
             :<|> withResource pool . matchParticipationListEndpoint
