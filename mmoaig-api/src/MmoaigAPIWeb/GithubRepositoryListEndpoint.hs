{-# LANGUAGE DeriveGeneric     #-}
{-# LANGUAGE RecordWildCards   #-}
{-# LANGUAGE OverloadedStrings #-}
module MmoaigAPIWeb.GithubRepositoryListEndpoint (GithubRepositoryListEndpointData, githubRepositoryListEndpoint) where

import GHC.Generics (Generic)
import Data.Aeson (ToJSON, toJSON, object, (.=), Value(String))
import Servant (Handler)
import Control.Monad.IO.Class (liftIO)
import Database.PostgreSQL.Simple (Connection)

import MmoaigAPI.GithubRepositories (loadGithubRepositoryList)

import MmoaigAPI.Schema (dbGithubRepositoryGithubUserId, GithubRepositoryTableT(GithubRepositoryTable), dbGithubRepositoryId, dbGithubRepositoryName, GithubRepositoryTable)

data GithubRepositoryListEndpointAttributes = GithubRepositoryListEndpointAttributes
  { name :: String
  } deriving Generic

instance ToJSON GithubRepositoryListEndpointAttributes

data GithubRepositoryListEndpointResource = GithubRepositoryListEndpointResource
  { userListEndpointResourceId :: Int
  , attributes                 :: GithubRepositoryListEndpointAttributes
  }

instance ToJSON GithubRepositoryListEndpointResource where
  toJSON GithubRepositoryListEndpointResource{..} = object [ "id"         .= userListEndpointResourceId 
                                                           , "type"       .= String "github_repositories"
                                                           , "attributes" .= toJSON attributes
                                                           ]

data GithubRepositoryListEndpointData = GithubRepositoryListEndpointData
  { endpointData :: [GithubRepositoryListEndpointResource]
  }

instance ToJSON GithubRepositoryListEndpointData where
  toJSON GithubRepositoryListEndpointData{..} = object [ "data" .= endpointData ]

githubRepositoryListEndpoint :: Connection -> Handler GithubRepositoryListEndpointData
githubRepositoryListEndpoint connection = do
  repositories <- liftIO $ loadGithubRepositoryList connection
  return $ GithubRepositoryListEndpointData $ map createResource repositories

createResource :: GithubRepositoryTable -> GithubRepositoryListEndpointResource
createResource GithubRepositoryTable{..} = GithubRepositoryListEndpointResource dbGithubRepositoryId attributes
  where
    attributes = GithubRepositoryListEndpointAttributes dbGithubRepositoryName
