{-# LANGUAGE RecordWildCards   #-}
{-# LANGUAGE OverloadedStrings #-}
module MmoaigAPIWeb.UpdateMatchEndpoint (updateMatchEndpoint, UpdateMatchEndpointData(UpdateMatchEndpointData)) where

import Database.PostgreSQL.Simple (Connection)
import Servant (Handler, throwError, err404)
import Data.Aeson (ToJSON, toJSON, object, FromJSON, parseJSON, withObject, (.:), (.=), Value(String))
import Control.Monad.IO.Class (liftIO)

import MmoaigAPI.Matches (updateMatch)
import MmoaigAPI.Schema (DBMatchStatus(DBMatchCancelled, DBMatchPending, DBMatchInProgress, DBMatchComplete))

data MatchStatusUpdate = MatchPending
                       | MatchInProgress
                       | MatchComplete
                       | MatchCancelled
                       deriving (Show)

instance FromJSON MatchStatusUpdate where
  parseJSON "MatchPending"    = pure MatchPending
  parseJSON "MatchInProgress" = pure MatchInProgress
  parseJSON "MatchComplete"   = pure MatchComplete
  parseJSON "MatchCancelled"  = pure MatchCancelled
  parseJSON _                 = mempty

instance ToJSON MatchStatusUpdate where
  toJSON MatchPending    = String "MatchPending"
  toJSON MatchInProgress = String "MatchInProgress"
  toJSON MatchComplete   = String "MatchComplete"
  toJSON MatchCancelled  = String "MatchCancelled"

newtype UpdateMatchEndpointData =
  UpdateMatchEndpointData
  { newMatchStatus :: MatchStatusUpdate
  }

instance ToJSON UpdateMatchEndpointData where
  toJSON UpdateMatchEndpointData{..} = object [ "status" .= newMatchStatus ]

instance FromJSON UpdateMatchEndpointData where
  parseJSON = withObject "UpdateMatchEndpointData" $ \v -> UpdateMatchEndpointData 
    <$> v .: "status"

-- TODO: Don't just cancel the matches
updateMatchEndpoint :: Int -> UpdateMatchEndpointData -> Connection -> Handler UpdateMatchEndpointData
updateMatchEndpoint matchId update connection = do
  result <- liftIO $ updateMatch matchId convertedStatus connection
  case result of
    Just _  -> return update
    _       -> throwError err404
   
  where
    convertedStatus = convertStatus (newMatchStatus update)
    convertStatus MatchPending    = DBMatchPending
    convertStatus MatchInProgress = DBMatchInProgress
    convertStatus MatchComplete   = DBMatchComplete
    convertStatus MatchCancelled  = DBMatchCancelled
