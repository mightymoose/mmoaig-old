{-# LANGUAGE RecordWildCards   #-}
{-# LANGUAGE OverloadedStrings #-}
module MmoaigAPIWeb.Representers.GithubUserRepresenter (createGithubUserIdentifier, createGithubUserObject, GithubUserAttributes) where

import Data.Aeson (ToJSON, toJSON, FromJSON, parseJSON, object, (.=), withObject, (.:))
import Data.Time (LocalTime)

import MmoaigAPI.Schema (dbGithubUserCreatedAt, dbGithubUserUpdatedAt, PrimaryKey(UserTableId), GithubUserTable, GithubUserTableT(GithubUserTable), dbGithubUserId, dbGithubUserUsername, dbGithubUserUserId)
import MmoaigAPIWeb.Representers.JSONApi (ResourceIdentifier(ResourceIdentifier), ResourceObject(ResourceObject))

data GithubUserAttributes = GithubUserAttributes
  { githubUserUsername  :: String
  , githubUserUserId    :: Int
  , githubUserCreatedAt :: LocalTime
  , githubUserUpdatedAt :: LocalTime
  }

-- TODO: Test this
instance ToJSON GithubUserAttributes where
  toJSON GithubUserAttributes{..} = object [ "username"  .= githubUserUsername 
                                           , "userId"    .= githubUserUserId
                                           , "createdAt" .= githubUserCreatedAt
                                           , "updatedAt" .= githubUserUpdatedAt
                                           ]

-- TODO: Test this
instance FromJSON GithubUserAttributes where
  parseJSON = withObject "GithubUserAttributes" $ \o -> do
    githubUserUsername  <- o .: "username"
    githubUserUserId    <- o .: "userId"
    githubUserCreatedAt <- o .: "createdAt"
    githubUserUpdatedAt <- o .: "updatedAt"
    return GithubUserAttributes{..}

-- TODO: Test this
createGithubUserIdentifier :: GithubUserTable -> ResourceIdentifier
createGithubUserIdentifier GithubUserTable{..} = ResourceIdentifier dbGithubUserId "github_users"

-- TODO: Test this
createGithubUserObject :: GithubUserTable -> ResourceObject GithubUserAttributes ()
createGithubUserObject githubUser@GithubUserTable{..} = ResourceObject identifier (Just attributes) Nothing
  where
    attributes = GithubUserAttributes dbGithubUserUsername userId dbGithubUserCreatedAt dbGithubUserUpdatedAt
    identifier = createGithubUserIdentifier githubUser 
    (UserTableId userId) = dbGithubUserUserId
