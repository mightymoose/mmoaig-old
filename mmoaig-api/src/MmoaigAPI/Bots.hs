{-# LANGUAGE DataKinds             #-}
{-# LANGUAGE TypeOperators         #-}
{-# LANGUAGE FlexibleInstances     #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE OverloadedStrings     #-}
module MmoaigAPI.Bots (loadBotList, loadBotSource) where

import Database.PostgreSQL.Simple (Connection)
import Control.Monad.IO.Class (liftIO)
import Database.Beam.Postgres (runBeamPostgres)
import Database.Beam (val_, guard_, runSelectReturningList, select, all_, limit_, related_, (==.)) 
import Servant ((:>), Get, Proxy(Proxy), Capture, Header, MimeUnrender, mimeUnrender, Accept, contentType)
import Servant.Client (client, ClientM, runClientM, mkClientEnv, BaseUrl(BaseUrl), Scheme(Https))
import Network.HTTP.Client.TLS (newTlsManager)
import Data.ByteString.Lazy.Char8 (unpack)
import Network.HTTP.Media ((//))

import MmoaigAPI.Schema (BotTable, dbBots, mmoaigAPIDatabase, GithubRepositoryTable, dbGithubRepositories, dbBotGithubRepositoryId, dbBotId, dbBotPath, dbGithubRepositoryName, dbGithubUsers, dbGithubRepositoryGithubUserId, GithubUserTable, dbGithubUserUsername)

data RepositoryContent
instance MimeUnrender RepositoryContent String where
  mimeUnrender _ = return . unpack 

instance Accept RepositoryContent where
 contentType _ = "application" // "vnd.github.VERSION.raw"

type GithubAPI = Header "User-Agent" String :> "repos" :> Capture "username" String :> Capture "repositoryName" String :> "contents" :> Capture "botPath" String :> Get '[RepositoryContent] String

githubAPI :: Proxy GithubAPI
githubAPI = Proxy

requestGithubRepositoryContents :: Maybe String ->  String -> String -> String -> ClientM String
requestGithubRepositoryContents = client githubAPI

loadBotList :: Connection -> IO [BotTable]
loadBotList connection =
  liftIO $ runBeamPostgres connection $
    runSelectReturningList $ select $ limit_ 25 $
      all_ (dbBots mmoaigAPIDatabase)

fetchSourceForBot :: String -> String -> String -> IO String
fetchSourceForBot userName repositoryName botPath = do
  manager' <- newTlsManager 
  let contentRequest = requestGithubRepositoryContents (Just "mightymoose") userName repositoryName botPath
  r <- runClientM contentRequest (mkClientEnv manager' (BaseUrl Https "api.github.com" 443 ""))
  case r of
    Right source -> return source
    _            -> return $ show r -- TODO: Fix this to show an actual error!

-- TODO: Test this
loadBotSource :: Int -> Connection -> IO String
loadBotSource botId connection = do
  botLocator <- loadBotLocation botId connection
  case botLocator of
    [(user, repository, bot)] -> fetchSourceForBot  (dbGithubUserUsername user) (dbGithubRepositoryName repository) (dbBotPath bot)
    _ -> return "" -- TODO: Fix this to show an actual error

loadBotLocation :: Int -> Connection -> IO [(GithubUserTable, GithubRepositoryTable, BotTable)]
loadBotLocation botId connection = 
  liftIO $ runBeamPostgres connection $ 
    runSelectReturningList $ select $ do
      bots <- all_ (dbBots mmoaigAPIDatabase)
      repositories <- related_ (dbGithubRepositories mmoaigAPIDatabase) (dbBotGithubRepositoryId bots)
      users <- related_ (dbGithubUsers mmoaigAPIDatabase) (dbGithubRepositoryGithubUserId repositories)
      guard_ (dbBotId bots ==. val_ botId)
      pure (users, repositories, bots)
 
