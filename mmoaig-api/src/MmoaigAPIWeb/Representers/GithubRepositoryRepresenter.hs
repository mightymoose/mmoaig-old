{-# LANGUAGE RecordWildCards   #-}
{-# LANGUAGE OverloadedStrings #-}
module MmoaigAPIWeb.Representers.GithubRepositoryRepresenter (createGithubRepositoryIdentifier, createGithubRepositoryObject, GithubRepositoryAttributes) where

import Data.Aeson (ToJSON, toJSON, FromJSON, parseJSON, object, withObject, (.:), (.=))
import Data.Time (LocalTime)

import MmoaigAPI.Schema (GithubRepositoryTableT(GithubRepositoryTable), GithubRepositoryTable, dbGithubRepositoryId, dbGithubRepositoryName, dbGithubRepositoryCreatedAt, dbGithubRepositoryUpdatedAt, dbGithubRepositoryGithubUserId, PrimaryKey(GithubUserTableId))
import MmoaigAPIWeb.Representers.JSONApi (ResourceIdentifier(ResourceIdentifier), ResourceObject(ResourceObject))

data GithubRepositoryAttributes = GithubRepositoryAttributes
  { githubRepositoryName         :: String
  , githubRepositoryCreatedAt    :: LocalTime
  , githubRepositoryUpdatedAt    :: LocalTime
  , githubRepositoryGithubUserId :: Int
  }

-- TODO: Test this
instance ToJSON GithubRepositoryAttributes where
  toJSON GithubRepositoryAttributes{..} = object [ "name"         .= githubRepositoryName 
                                                 , "createdAt"    .= githubRepositoryCreatedAt
                                                 , "updatedAt"    .= githubRepositoryUpdatedAt
                                                 , "githubUserId" .= githubRepositoryGithubUserId
                                                 ]
 
-- TODO: Test this
instance FromJSON GithubRepositoryAttributes where
  parseJSON = withObject "GithubRepositoryAttributes" $ \o -> do
    githubRepositoryName         <- o .: "name"
    githubRepositoryCreatedAt    <- o .: "createdAt"
    githubRepositoryUpdatedAt    <- o .: "updatedAt"
    githubRepositoryGithubUserId <- o .: "githubUserId"
    return GithubRepositoryAttributes{..}

-- TODO: Test this
createGithubRepositoryIdentifier :: GithubRepositoryTable -> ResourceIdentifier
createGithubRepositoryIdentifier GithubRepositoryTable{..} = ResourceIdentifier dbGithubRepositoryId "github_repositories"

-- TODO: Test this
createGithubRepositoryObject :: GithubRepositoryTable -> ResourceObject GithubRepositoryAttributes ()
createGithubRepositoryObject githubRepository@GithubRepositoryTable{..} = ResourceObject identifier (Just attributes) Nothing
  where
    attributes = GithubRepositoryAttributes dbGithubRepositoryName dbGithubRepositoryCreatedAt dbGithubRepositoryUpdatedAt userID
    identifier = createGithubRepositoryIdentifier githubRepository
    (GithubUserTableId userID) = dbGithubRepositoryGithubUserId
