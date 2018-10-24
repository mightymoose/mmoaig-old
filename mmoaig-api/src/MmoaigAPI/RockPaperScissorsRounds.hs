module MmoaigAPI.RockPaperScissorsRounds (loadRockPaperScissorsRoundList) where

import Database.PostgreSQL.Simple (Connection)
import Control.Monad.IO.Class (liftIO)
import Database.Beam.Postgres (runBeamPostgres)
import Database.Beam (select, limit_, runSelectReturningList, all_)

import MmoaigAPI.Schema (RockPaperScissorsRoundTable, dbRockPaperScissorsRounds, mmoaigAPIDatabase)

loadRockPaperScissorsRoundList :: Connection -> IO [RockPaperScissorsRoundTable]
loadRockPaperScissorsRoundList connection =
  liftIO $ runBeamPostgres connection $
    runSelectReturningList $ select $ limit_ 25 $
      all_ (dbRockPaperScissorsRounds mmoaigAPIDatabase)
 
