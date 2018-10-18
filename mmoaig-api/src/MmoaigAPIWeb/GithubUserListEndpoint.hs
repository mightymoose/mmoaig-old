{-# LANGUAGE DeriveGeneric     #-}
{-# LANGUAGE RecordWildCards   #-}
{-# LANGUAGE OverloadedStrings #-}
module MmoaigAPIWeb.GithubUserListEndpoint (GithubUserListEndpointData, githubUserListEndpoint) where

import GHC.Generics (Generic)
import Data.Aeson (ToJSON, toJSON, object, (.=), Value(String))
import Servant (Handler)
import Control.Monad.IO.Class (liftIO)
import Database.PostgreSQL.Simple (Connection)

import MmoaigAPI.GithubUsers (loadGithubUserList)

import MmoaigAPI.Schema (GithubUserTableT(GithubUserTable), GithubUserTable, dbGithubUserId, dbGithubUserUsername, dbGithubUserUserId)

newtype GithubUserListEndpointAttributes = GithubUserListEndpointAttributes
  { username :: String
  } deriving Generic

instance ToJSON GithubUserListEndpointAttributes

data GithubUserListEndpointResource = GithubUserListEndpointResource
  { githubUserListEndpointResourceId :: Int
  , attributes                 :: GithubUserListEndpointAttributes
  }

instance ToJSON GithubUserListEndpointResource where
  toJSON GithubUserListEndpointResource{..} = object [ "id"         .= githubUserListEndpointResourceId 
                                                     , "type"       .= String "github_users"
                                                     , "attributes" .= toJSON attributes
                                                     ]

newtype GithubUserListEndpointData = GithubUserListEndpointData
  { endpointData :: [GithubUserListEndpointResource]
  }

instance ToJSON GithubUserListEndpointData where
  toJSON GithubUserListEndpointData{..} = object [ "data" .= endpointData ]

githubUserListEndpoint :: Connection -> Handler GithubUserListEndpointData
githubUserListEndpoint connection = do
  githubUsers <- liftIO $ loadGithubUserList connection
  return $ GithubUserListEndpointData $ map createResource githubUsers

createResource :: GithubUserTable -> GithubUserListEndpointResource
createResource GithubUserTable{..} = GithubUserListEndpointResource dbGithubUserId attributes
  where
    attributes = GithubUserListEndpointAttributes dbGithubUserUsername
