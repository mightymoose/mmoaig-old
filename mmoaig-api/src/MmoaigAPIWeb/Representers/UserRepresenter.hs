{-# LANGUAGE RecordWildCards   #-}
{-# LANGUAGE OverloadedStrings #-}
module MmoaigAPIWeb.Representers.UserRepresenter (createUserIdentifier, createUserObject, UserAttributes) where

import Data.Aeson (ToJSON, toJSON, FromJSON, parseJSON, object, (.=), withObject, (.:))

import MmoaigAPI.Schema (UserTable, UserTableT(UserTable), dbUserId, dbUserActive, dbUserUsername)
import MmoaigAPIWeb.Representers.JSONApi (ResourceIdentifier(ResourceIdentifier), ResourceObject(ResourceObject))

data UserAttributes = UserAttributes
  { userUsername :: String
  , userActive   :: Bool
  }

-- TODO: Test this
instance ToJSON UserAttributes where
  toJSON UserAttributes{..} = object [ "username" .= userUsername 
                                     , "active"   .= userActive
                                     ]

-- TODO: Test this
instance FromJSON UserAttributes where
  parseJSON = withObject "UserAttributes" $ \o -> do
    userUsername <- o .: "username"
    userActive   <- o .: "active"
    return UserAttributes{..}

-- TODO: Test this
createUserIdentifier :: UserTable -> ResourceIdentifier
createUserIdentifier UserTable{..} = ResourceIdentifier dbUserId "users"

-- TODO: Test this
createUserObject :: UserTable -> ResourceObject UserAttributes ()
createUserObject user@UserTable{..} = ResourceObject identifier (Just attributes) Nothing
  where
    attributes = UserAttributes dbUserUsername dbUserActive
    identifier = createUserIdentifier user
