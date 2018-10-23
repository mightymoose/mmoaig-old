{-# LANGUAGE RecordWildCards   #-}
{-# LANGUAGE OverloadedStrings #-}
module MmoaigAPIWeb.Representers.BotRepresenter (createBotIdentifier, createBotObject, BotAttributes) where

import Data.Aeson (ToJSON, toJSON, FromJSON, parseJSON, object, (.=), withObject, (.:))

import MmoaigAPI.Schema (BotTable, BotTableT(BotTable), dbBotId, dbBotPath)
import MmoaigAPIWeb.Representers.JSONApi (ResourceIdentifier(ResourceIdentifier), ResourceObject(ResourceObject))

newtype BotAttributes = BotAttributes { botPath :: String }

-- TODO: Test this
instance ToJSON BotAttributes where
  toJSON BotAttributes{..} = object [ "path" .= botPath ] 

-- TODO: Test this
instance FromJSON BotAttributes where
  parseJSON = withObject "BotAttributes" $ \o -> do
    botPath <- o .: "path"
    return BotAttributes{..}

-- TODO: Test this
createBotIdentifier :: BotTable -> ResourceIdentifier
createBotIdentifier BotTable{..} = ResourceIdentifier dbBotId "bots"

-- TODO: Test this
createBotObject :: BotTable -> ResourceObject BotAttributes ()
createBotObject user@BotTable{..} = ResourceObject identifier (Just attributes) Nothing
  where
    attributes = BotAttributes dbBotPath
    identifier = createBotIdentifier user
