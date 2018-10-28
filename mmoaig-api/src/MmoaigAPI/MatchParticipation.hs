module MmoaigAPI.MatchParticipation (loadMatchParticipation) where

import Database.PostgreSQL.Simple (Connection)

import MmoaigAPI.Schema (dbMatchParticipationMatchId, dbMatchParticipationId, MatchParticipationTable, dbMatchParticipation, mmoaigAPIDatabase, PrimaryKey(MatchTableId), dbMatchParticipation)
import Database.Beam.Postgres (runBeamPostgres)
import Database.Beam (runSelectReturningList, select, all_, limit_, guard_, (==.), val_, orderBy_, asc_)
import Control.Monad.IO.Class (liftIO)

loadMatchParticipation :: Maybe Int -> Connection -> IO [MatchParticipationTable]
loadMatchParticipation Nothing connection =
  liftIO $ runBeamPostgres connection $
  runSelectReturningList $ select $ limit_ 25 $ orderBy_ (asc_ . dbMatchParticipationId) $
    all_ (dbMatchParticipation mmoaigAPIDatabase)
loadMatchParticipation (Just matchId) connection = 
  liftIO $ runBeamPostgres connection $
  runSelectReturningList $ select $ limit_ 25 $ do
    participation <- all_ (dbMatchParticipation mmoaigAPIDatabase)
    guard_ (dbMatchParticipationMatchId participation ==. val_ (MatchTableId matchId))
    pure participation

