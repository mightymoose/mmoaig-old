{-# LANGUAGE OverloadedStrings #-}
module TestUtilities (withDatabaseConnection, testApp, putJSON) where

import Database.PostgreSQL.Simple (Connection, ConnectInfo(ConnectInfo), connect, begin, rollback, close)
import Control.Exception.Base (bracket)
import Network.Wai (Application)
import Servant (serve)
import Data.Pool (Pool, createPool)
import Test.Hspec.Wai (WaiSession, request)
import Network.HTTP.Types (methodPut)
import Data.ByteString (ByteString)
import Network.Wai.Test (SResponse)
import qualified Data.ByteString.Lazy as LB

import Lib (api, server)

testDatabaseConnectionInfo :: ConnectInfo
testDatabaseConnectionInfo = ConnectInfo "localhost" 5432 "postgres" "postgres" "mmoaig_api_test"

openDatabaseConnection :: IO Connection
openDatabaseConnection = do
  connection <- connect testDatabaseConnectionInfo
  begin connection
  return connection

closeDatabaseConnection :: Connection -> IO ()
closeDatabaseConnection connection = do
  rollback connection
  close connection

withDatabaseConnection :: (Connection -> IO ()) -> IO ()
withDatabaseConnection = bracket openDatabaseConnection closeDatabaseConnection

testConnectionPool :: IO (Pool Connection)
testConnectionPool = createPool openDatabaseConnection closeDatabaseConnection 2 60 10

testApp :: IO Application
testApp = serve api . server <$> testConnectionPool

putJSON :: ByteString -> LB.ByteString -> WaiSession SResponse
putJSON path =  request methodPut path [("Content-Type", "application/json")]
