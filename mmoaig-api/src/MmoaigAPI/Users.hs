module MmoaigAPI.Users (loadUserList) where

import Database.PostgreSQL.Simple (Connection)
import Control.Monad.IO.Class (liftIO)
import Database.Beam.Postgres (runBeamPostgres)
import Database.Beam (runSelectReturningList, select, all_, limit_)

import MmoaigAPI.Schema (UserTable, dbUsers, mmoaigAPIDatabase)

loadUserList :: Connection -> IO [UserTable]
loadUserList connection =
  liftIO $ runBeamPostgres connection $
    runSelectReturningList $ select $ limit_ 25 $
      all_ (dbUsers mmoaigAPIDatabase)

-- createUser :: Connection -> NewUserTable -> UserTable
-- createUser = _