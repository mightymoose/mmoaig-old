{-# LANGUAGE RecordWildCards   #-}
{-# LANGUAGE OverloadedStrings #-}
module MmoaigAPIWeb.Representers.GithubRepositoryRepresenter (createGithubRepositoryIdentifier, createGithubRepositoryObject, GithubRepositoryAttributes) where

import Data.Aeson (ToJSON, toJSON, FromJSON, parseJSON, object, withObject, (.:), (.=))

import MmoaigAPI.Schema (GithubRepositoryTableT(GithubRepositoryTable), GithubRepositoryTable, dbGithubRepositoryId, dbGithubRepositoryName)
import MmoaigAPIWeb.Representers.JSONApi (ResourceIdentifier(ResourceIdentifier), ResourceObject(ResourceObject))

newtype GithubRepositoryAttributes = GithubRepositoryAttributes
  { githubRepositoryName :: String
  }

-- TODO: Test this
instance ToJSON GithubRepositoryAttributes where
  toJSON GithubRepositoryAttributes{..} = object [ "name" .= githubRepositoryName ]

-- TODO: Test this
instance FromJSON GithubRepositoryAttributes where
  parseJSON = withObject "GithubRepositoryAttributes" $ \o -> do
    githubRepositoryName <- o .: "name"
    return GithubRepositoryAttributes{..}

-- TODO: Test this
createGithubRepositoryIdentifier :: GithubRepositoryTable -> ResourceIdentifier
createGithubRepositoryIdentifier GithubRepositoryTable{..} = ResourceIdentifier dbGithubRepositoryId "github_repositories"

-- TODO: Test this
createGithubRepositoryObject :: GithubRepositoryTable -> ResourceObject GithubRepositoryAttributes ()
createGithubRepositoryObject githubRepository@GithubRepositoryTable{..} = ResourceObject identifier (Just attributes) Nothing
  where
    attributes = GithubRepositoryAttributes dbGithubRepositoryName
    identifier = createGithubRepositoryIdentifier githubRepository
