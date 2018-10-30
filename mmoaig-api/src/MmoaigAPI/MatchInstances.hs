module MmoaigAPI.MatchInstances (createMatchInstanceForMatch, loadMatchInstanceList, mostRecentInstanceForMatch) where

import Database.PostgreSQL.Simple (Connection)
import Control.Monad.IO.Class (liftIO)
import Database.Beam.Postgres (runBeamPostgres)
import Database.Beam (default_, runSelectReturningList, select, all_, limit_, guard_, (==.), val_, insertExpressions, orderBy_, asc_, currentTimestamp_, desc_)
import Database.Beam.Backend.SQL.BeamExtensions (runInsertReturningList)

import MmoaigAPI.Schema (MatchInstanceTable, PrimaryKey(MatchTableId), MatchInstanceTableT(MatchInstanceTable), dbMatchInstances, mmoaigAPIDatabase, dbMatchInstanceMatchId, dbMatchInstanceId, dbMatchInstanceCreatedAt)

loadMatchInstanceList :: Maybe Int -> Connection -> IO [MatchInstanceTable]
loadMatchInstanceList Nothing connection =
  liftIO $ runBeamPostgres connection $
  runSelectReturningList $ select $ limit_ 25 $ orderBy_ (asc_ . dbMatchInstanceId) $
    all_ (dbMatchInstances mmoaigAPIDatabase)
loadMatchInstanceList (Just matchId) connection =
  liftIO $ runBeamPostgres connection $
  runSelectReturningList $ select $ limit_ 25 $ orderBy_ (asc_ . dbMatchInstanceId) $ do
    instances <- all_ (dbMatchInstances mmoaigAPIDatabase)
    guard_ (dbMatchInstanceMatchId instances ==. val_ (MatchTableId matchId))
    pure instances

createMatchInstanceForMatch :: Int -> Connection -> IO MatchInstanceTable
createMatchInstanceForMatch matchId connection = liftIO $ do
  [newMatchInstance] <- runBeamPostgres connection $ runInsertReturningList (dbMatchInstances mmoaigAPIDatabase) $
    insertExpressions [MatchInstanceTable default_ (val_ "test") (val_ (MatchTableId matchId)) currentTimestamp_ currentTimestamp_]
  return newMatchInstance

-- This will be subsumed eventually
-- TODO: Learn how to DRY up these queries
-- TODO: Test this
mostRecentInstanceForMatch :: Int -> Connection -> IO (Maybe MatchInstanceTable)
mostRecentInstanceForMatch matchId connection = liftIO $ do 
  mostRecentInstance <- runBeamPostgres connection $
    runSelectReturningList $ select $ limit_ 1 $ orderBy_ (desc_ . dbMatchInstanceCreatedAt) $ do
      instances <- all_ (dbMatchInstances mmoaigAPIDatabase)
      guard_ (dbMatchInstanceMatchId instances ==. val_ (MatchTableId matchId))
      pure instances
  case mostRecentInstance of
    [i] -> return $ Just i
    _   -> return Nothing
