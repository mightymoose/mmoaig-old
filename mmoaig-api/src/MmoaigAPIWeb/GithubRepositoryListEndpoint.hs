module MmoaigAPIWeb.GithubRepositoryListEndpoint (GithubRepositoryListEndpointData, githubRepositoryListEndpoint) where

import Servant (Handler)
import Control.Monad.IO.Class (liftIO)
import Database.PostgreSQL.Simple (Connection)

import MmoaigAPI.GithubRepositories (loadGithubRepositoryList)

import MmoaigAPIWeb.Representers.JSONApi (JSONAPIResponse(SuccessResponse), PrimaryData(ResourceObjects))
import MmoaigAPIWeb.Representers.GithubRepositoryRepresenter (createGithubRepositoryObject, GithubRepositoryAttributes)

type GithubRepositoryListEndpointData = JSONAPIResponse GithubRepositoryAttributes ()

githubRepositoryListEndpoint :: Connection -> Handler GithubRepositoryListEndpointData
githubRepositoryListEndpoint connection = do
  repositories <- liftIO $ loadGithubRepositoryList connection
  return $ SuccessResponse $ ResourceObjects $ map createGithubRepositoryObject repositories
