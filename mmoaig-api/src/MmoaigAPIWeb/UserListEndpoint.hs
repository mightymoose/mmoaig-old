module MmoaigAPIWeb.UserListEndpoint (UserListEndpointData, userListEndpoint) where

import Servant (Handler)
import Control.Monad.IO.Class (liftIO)
import Database.PostgreSQL.Simple (Connection)

import MmoaigAPIWeb.Representers.JSONApi (JSONAPIResponse(SuccessResponse), PrimaryData(ResourceObjects))

import MmoaigAPIWeb.Representers.UserRepresenter (createUserObject, UserAttributes)

import MmoaigAPI.Users (loadUserList)

type UserListEndpointData = JSONAPIResponse UserAttributes ()

userListEndpoint :: Connection -> Handler UserListEndpointData
userListEndpoint connection = do
  users <- liftIO $ loadUserList connection
  return $ SuccessResponse $ ResourceObjects $ map createUserObject users
