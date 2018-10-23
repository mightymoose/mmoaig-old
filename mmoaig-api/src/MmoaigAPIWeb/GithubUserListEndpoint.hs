module MmoaigAPIWeb.GithubUserListEndpoint (GithubUserListEndpointData, githubUserListEndpoint) where

import Servant (Handler)
import Control.Monad.IO.Class (liftIO)
import Database.PostgreSQL.Simple (Connection)

import MmoaigAPI.GithubUsers (loadGithubUserList)
import MmoaigAPIWeb.Representers.JSONApi (JSONAPIResponse(SuccessResponse), PrimaryData(ResourceObjects))

import MmoaigAPIWeb.Representers.GithubUserRepresenter (createGithubUserObject, GithubUserAttributes)

type GithubUserListEndpointData = JSONAPIResponse GithubUserAttributes ()

githubUserListEndpoint :: Connection -> Handler GithubUserListEndpointData
githubUserListEndpoint connection = do
  githubUsers <- liftIO $ loadGithubUserList connection
  return $ SuccessResponse $ ResourceObjects $ map createGithubUserObject githubUsers
