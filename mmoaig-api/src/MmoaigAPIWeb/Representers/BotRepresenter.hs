{-# LANGUAGE RecordWildCards   #-}
{-# LANGUAGE OverloadedStrings #-}
module MmoaigAPIWeb.Representers.BotRepresenter (representBot, BotAttributes) where

import Data.Aeson (ToJSON, toJSON, object, (.=))

import MmoaigAPIWeb.Representers.APIResponse (ResourceIdentifier(ResourceIdentifier))
import MmoaigAPI.Schema ( BotTable
                        , BotTableT(BotTable)
                        , dbBotId
                        , dbBotPath
                        )

newtype BotAttributes = BotAttributes String

instance ToJSON BotAttributes where
  toJSON (BotAttributes p) = object [ "path" .= p ]

representBot :: BotTable -> ResourceIdentifier BotAttributes t
representBot BotTable{..} = ResourceIdentifier dbBotId "bots" $ BotAttributes dbBotPath
