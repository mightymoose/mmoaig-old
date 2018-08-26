module MmoaigAPI.GithubUsers (loadGithubUserList) where

import Database.PostgreSQL.Simple (Connection)
import Control.Monad.IO.Class (liftIO)
import Database.Beam.Postgres (runBeamPostgres)
import Database.Beam (runSelectReturningList, select, all_, limit_)

import MmoaigAPI.Schema (GithubUserTable, dbGithubUsers, mmoaigAPIDatabase)

loadGithubUserList :: Connection -> IO [GithubUserTable]
loadGithubUserList connection =
  liftIO $ runBeamPostgres connection $
    runSelectReturningList $ select $ limit_ 25 $
      all_ (dbGithubUsers mmoaigAPIDatabase)
