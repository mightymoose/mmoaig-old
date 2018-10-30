{-# LANGUAGE RecordWildCards   #-}
{-# LANGUAGE OverloadedStrings #-}
module MmoaigAPIWeb.Representers.BotRepresenter (createBotIdentifier, createBotObject, BotAttributes) where

import Data.Aeson (ToJSON, toJSON, FromJSON, parseJSON, object, (.=), withObject, (.:))
import Data.Time (LocalTime)

import MmoaigAPI.Schema (BotTable, BotTableT(BotTable), dbBotId, dbBotPath, dbBotCreatedAt, dbBotUpdatedAt, dbBotGithubRepositoryId, PrimaryKey(GithubRepositoryTableId))
import MmoaigAPIWeb.Representers.JSONApi (ResourceIdentifier(ResourceIdentifier), ResourceObject(ResourceObject))

data BotAttributes = BotAttributes { botPath               :: String 
                                   , botUpdatedAt          :: LocalTime
                                   , botCreatedAt          :: LocalTime
                                   , botGithubRepositoryId :: Int
                                   }

-- TODO: Test this
instance ToJSON BotAttributes where
  toJSON BotAttributes{..} = object [ "path"               .= botPath 
                                    , "updatedAt"          .= botUpdatedAt
                                    , "createdAt"          .= botCreatedAt
                                    , "githubRepositoryId" .= botGithubRepositoryId
                                    ] 

-- TODO: Test this
instance FromJSON BotAttributes where
  parseJSON = withObject "BotAttributes" $ \o -> do
    botPath               <- o .: "path"
    botUpdatedAt          <- o .: "updatedAt"
    botCreatedAt          <- o .: "createdAt"
    botGithubRepositoryId <- o .: "githubRepositoryId"
    return BotAttributes{..}

-- TODO: Test this
createBotIdentifier :: BotTable -> ResourceIdentifier
createBotIdentifier BotTable{..} = ResourceIdentifier dbBotId "bots"

-- TODO: Test this
createBotObject :: BotTable -> ResourceObject BotAttributes ()
createBotObject user@BotTable{..} = ResourceObject identifier (Just attributes) Nothing
  where
    attributes = BotAttributes dbBotPath dbBotUpdatedAt dbBotCreatedAt repositoryId
    identifier = createBotIdentifier user
    (GithubRepositoryTableId repositoryId) = dbBotGithubRepositoryId