{-# LANGUAGE RecordWildCards   #-}
{-# LANGUAGE OverloadedStrings #-}
module MmoaigAPIWeb.Representers.UserRepresenter (createUserIdentifier, createUserObject, UserAttributes) where

import Data.Aeson (ToJSON, toJSON, FromJSON, parseJSON, object, (.=), withObject, (.:))
import Data.Time (LocalTime)

import MmoaigAPI.Schema (UserTable, UserTableT(UserTable), dbUserId, dbUserActive, dbUserUsername, dbUserCreatedAt, dbUserUpdatedAt)
import MmoaigAPIWeb.Representers.JSONApi (ResourceIdentifier(ResourceIdentifier), ResourceObject(ResourceObject))

data UserAttributes = UserAttributes
  { userUsername  :: String
  , userActive    :: Bool
  , userCreatedAt :: LocalTime
  , userUpdatedAt :: LocalTime
  }

-- TODO: Test this
instance ToJSON UserAttributes where
  toJSON UserAttributes{..} = object [ "username"  .= userUsername 
                                     , "active"    .= userActive
                                     , "createdAt" .= userCreatedAt
                                     , "updatedAt" .= userUpdatedAt
                                     ]

-- TODO: Test this
instance FromJSON UserAttributes where
  parseJSON = withObject "UserAttributes" $ \o -> do
    userUsername  <- o .: "username"
    userActive    <- o .: "active"
    userCreatedAt <- o .: "createdAt"
    userUpdatedAt <- o .: "updatedAt"
    return UserAttributes{..}

-- TODO: Test this
createUserIdentifier :: UserTable -> ResourceIdentifier
createUserIdentifier UserTable{..} = ResourceIdentifier dbUserId "users"

-- TODO: Test this
createUserObject :: UserTable -> ResourceObject UserAttributes ()
createUserObject user@UserTable{..} = ResourceObject identifier (Just attributes) Nothing
  where
    attributes = UserAttributes dbUserUsername dbUserActive dbUserCreatedAt dbUserUpdatedAt
    identifier = createUserIdentifier user
