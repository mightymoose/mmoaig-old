module MmoaigAPI.Configuration (createConnectInfo, Configuration, createConfiguration, databaseConnectionPool) where

import Data.Pool (Pool, createPool)
import Database.PostgreSQL.Simple (Connection, ConnectInfo(ConnectInfo), connect, close)
    
import MmoaigAPI.Environment (Environment, postgresHost, postgresPort, postgresUser, postgresPassword, postgresDatabase)
    
newtype Configuration = Configuration { databaseConnectionPool :: Pool Connection } deriving (Show)
    
createConnectInfo :: Environment -> ConnectInfo
createConnectInfo = ConnectInfo <$> postgresHost 
                                <*> postgresPort 
                                <*> postgresUser 
                                <*> postgresPassword 
                                <*> postgresDatabase 
    
    
createConfiguration :: ConnectInfo -> IO Configuration
createConfiguration connectInfo = Configuration <$> pool
  where
    pool = createPool (connect connectInfo) close 2 60 10