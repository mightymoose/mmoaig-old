module MmoaigAPI.GithubRepositories (loadGithubRepositoryList) where

import Database.PostgreSQL.Simple (Connection)
import Control.Monad.IO.Class (liftIO)
import Database.Beam.Postgres (runBeamPostgres)
import Database.Beam (runSelectReturningList, select, all_, limit_)

import MmoaigAPI.Schema (GithubRepositoryTable, dbGithubRepositories, mmoaigAPIDatabase)

loadGithubRepositoryList :: Connection -> IO [GithubRepositoryTable]
loadGithubRepositoryList connection =
  liftIO $ runBeamPostgres connection $
    runSelectReturningList $ select $ limit_ 25 $
      all_ (dbGithubRepositories mmoaigAPIDatabase)
