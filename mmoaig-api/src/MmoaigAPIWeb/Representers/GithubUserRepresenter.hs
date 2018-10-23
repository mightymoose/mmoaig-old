{-# LANGUAGE RecordWildCards   #-}
{-# LANGUAGE OverloadedStrings #-}
module MmoaigAPIWeb.Representers.GithubUserRepresenter (createGithubUserIdentifier, createGithubUserObject, GithubUserAttributes) where

import Data.Aeson (ToJSON, toJSON, FromJSON, parseJSON, object, (.=), withObject, (.:))

import MmoaigAPI.Schema (GithubUserTable, GithubUserTableT(GithubUserTable), dbGithubUserId, dbGithubUserUsername)
import MmoaigAPIWeb.Representers.JSONApi (ResourceIdentifier(ResourceIdentifier), ResourceObject(ResourceObject))

newtype GithubUserAttributes = GithubUserAttributes
  { githubUserUsername :: String
  }

-- TODO: Test this
instance ToJSON GithubUserAttributes where
  toJSON GithubUserAttributes{..} = object [ "username" .= githubUserUsername ]

-- TODO: Test this
instance FromJSON GithubUserAttributes where
  parseJSON = withObject "GithubUserAttributes" $ \o -> do
    githubUserUsername <- o .: "username"
    return GithubUserAttributes{..}

-- TODO: Test this
createGithubUserIdentifier :: GithubUserTable -> ResourceIdentifier
createGithubUserIdentifier GithubUserTable{..} = ResourceIdentifier dbGithubUserId "github_users"

-- TODO: Test this
createGithubUserObject :: GithubUserTable -> ResourceObject GithubUserAttributes ()
createGithubUserObject githubUser@GithubUserTable{..} = ResourceObject identifier (Just attributes) Nothing
  where
    attributes = GithubUserAttributes dbGithubUserUsername
    identifier = createGithubUserIdentifier githubUser
