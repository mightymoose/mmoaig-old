{-# LANGUAGE DeriveGeneric     #-}
{-# LANGUAGE RecordWildCards   #-}
{-# LANGUAGE OverloadedStrings #-}
module MmoaigAPIWeb.UserListEndpoint (UserListEndpointData, userListEndpoint) where

import GHC.Generics (Generic)
import Data.Aeson (ToJSON, toJSON, object, (.=), Value(String))
import Servant (Handler)
import Control.Monad.IO.Class (liftIO)
import Database.PostgreSQL.Simple (Connection)

import MmoaigAPI.Users (loadUserList)

import MmoaigAPI.Schema (UserTableT(UserTable), dbUserId, dbUserUsername, UserTable, dbUserActive)

data UserListEndpointAttributes = UserListEndpointAttributes
  { username :: String
  , active   :: Bool
  } deriving Generic

instance ToJSON UserListEndpointAttributes

data UserListEndpointResource = UserListEndpointResource
  { userListEndpointResourceId :: Int
  , attributes                 :: UserListEndpointAttributes
  }

instance ToJSON UserListEndpointResource where
  toJSON UserListEndpointResource{..} = object [ "id"         .= userListEndpointResourceId 
                                               , "type"       .= String "users"
                                               , "attributes" .= toJSON attributes
                                               ]

newtype UserListEndpointData = UserListEndpointData
  { endpointData :: [UserListEndpointResource]
  }

instance ToJSON UserListEndpointData where
  toJSON UserListEndpointData{..} = object [ "data" .= endpointData ]

userListEndpoint :: Connection -> Handler UserListEndpointData
userListEndpoint connection = do
  users <- liftIO $ loadUserList connection
  return $ UserListEndpointData $ map createResource users

createResource :: UserTable -> UserListEndpointResource
createResource UserTable{..} = UserListEndpointResource dbUserId attributes
  where
    attributes = UserListEndpointAttributes dbUserUsername dbUserActive
