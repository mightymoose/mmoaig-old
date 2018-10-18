module MmoaigAPI.Configuration (createConnectInfo, Configuration, createConfiguration, databaseConnectionPool, secretKey) where

import Data.Pool (Pool, createPool)
import Database.PostgreSQL.Simple (Connection, ConnectInfo(ConnectInfo), connect, close)
    
import MmoaigAPI.Environment (Environment, postgresHost, postgresPort, postgresUser, postgresPassword, postgresDatabase, secret)
    
data Configuration = Configuration 
  { databaseConnectionPool :: Pool Connection
  , secretKey              :: String
  } deriving (Show)
    
createConnectInfo :: Environment -> ConnectInfo
createConnectInfo = ConnectInfo <$> postgresHost 
                                <*> postgresPort 
                                <*> postgresUser 
                                <*> postgresPassword 
                                <*> postgresDatabase 
    
    
createConfiguration :: Environment -> IO Configuration
createConfiguration environment = do
  let connectInfo = createConnectInfo environment
  pool <- createPool (connect connectInfo) close 2 60 10
  return $ Configuration pool (secret environment)