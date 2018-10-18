module MmoaigAPI.Environment ( Environment
                             , createEnvironment
                             , postgresHost
                             , postgresPort
                             , postgresUser
                             , postgresPassword
                             , postgresDatabase
                             , secret
                             ) where

import Data.Word (Word16)
import Text.Read (readMaybe)

data Environment = Environment
  { postgresHost     :: String
  , postgresPort     :: Word16
  , postgresUser     :: String
  , postgresPassword :: String
  , postgresDatabase :: String
  , secret           :: String
  } deriving (Show, Eq)

createEnvironment :: [(String, String)] -> Maybe Environment
createEnvironment env = 
  Environment <$> lookup "POSTGRES_HOST" env
              <*> (lookup "POSTGRES_PORT" env >>= readMaybe)
              <*> lookup "POSTGRES_USER" env
              <*> lookup "POSTGRES_PASSWORD" env
              <*> lookup "POSTGRES_DB" env
              <*> lookup "SECRET_KEY" env
