{-# LANGUAGE DeriveGeneric         #-}
{-# LANGUAGE TypeFamilies          #-}
{-# LANGUAGE FlexibleInstances     #-}
{-# LANGUAGE FlexibleContexts      #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE UndecidableInstances  #-}
{-# LANGUAGE OverloadedStrings     #-}
{-# LANGUAGE StandaloneDeriving    #-}
{-# LANGUAGE DeriveAnyClass        #-}
module MmoaigAPI.Schema ( UserTableT(UserTable)
                        , UserTable
                        , BotTableT(BotTable)
                        , BotTable
                        , GithubUserTableT(GithubUserTable)
                        , MatchTableT(MatchTable)
                        , dbMatchParticipationBotId
                        , dbMatchParticipationMatchId
                        , GithubUserTable
                        , dbGithubUserId
                        , dbGithubUserUsername
                        , dbGithubUserUserId
                        , dbGithubUsers
                        , dbUsers
                        , dbBots
                        , dbGithubRepositories
                        , mmoaigAPIDatabase
                        , dbUserId
                        , dbBotId
                        , dbBotGithubRepositoryId
                        , dbBotPath
                        , dbUserUsername
                        , dbUserActive
                        , DBMatchType(DBRockPaperScissorsMatch)
                        , GithubRepositoryTable
                        , dbGithubRepositoryId 
                        , dbGithubRepositoryGithubUserId 
                        , GithubRepositoryTableT(GithubRepositoryTable) 
                        , dbGithubRepositoryName
                        , dbMatches
                        , dbMatchParticipation
                        , dbMatchId
                        , PrimaryKey(MatchTableId)
                        , MatchTable
                        , dbMatchStatus
                        , dbMatchType
                        , DBMatchStatus(DBMatchPending, DBMatchInProgress
                        , DBMatchComplete
                        , DBMatchCancelled)
                        ) where

import Database.PostgreSQL.Simple.FromField (FromField, fromField)
import Database.Beam.Postgres.Syntax (PgExpressionSyntax)
import Database.Beam.Backend.SQL (HasSqlValueSyntax, sqlValueSyntax, autoSqlValueSyntax, BeamBackend)

import Database.Beam ( TableEntity
                     , Beamable
                     , FromBackendRow
                     , fromBackendRow
                     , Columnar
                     , Generic
                     , Identity
                     , Table
                     , PrimaryKey
                     , primaryKey
                     , HasSqlEqualityCheck
                     , DatabaseSettings
                     , defaultDbSettings
                     , Database
                     )

data GithubRepositoryTableT f = GithubRepositoryTable
  { dbGithubRepositoryId           :: Columnar f Int
  , dbGithubRepositoryName         :: Columnar f String
  , dbGithubRepositoryGithubUserId :: PrimaryKey GithubUserTableT f
  } deriving Generic

type GithubRepositoryTable = GithubRepositoryTableT Identity

type GithubRepositoryTableId = PrimaryKey GithubRepositoryTableT Identity
deriving instance Eq GithubRepositoryTableId

instance Beamable GithubRepositoryTableT
instance Beamable (PrimaryKey GithubRepositoryTableT)

instance Table GithubRepositoryTableT where
  data PrimaryKey GithubRepositoryTableT f = GithubRepositoryTableId (Columnar f Int) deriving Generic
  primaryKey = GithubRepositoryTableId . dbGithubRepositoryId

deriving instance Show (PrimaryKey GithubRepositoryTableT Identity)

data UserTableT f = UserTable 
  { dbUserId       :: Columnar f Int
  , dbUserUsername :: Columnar f String
  , dbUserActive   :: Columnar f Bool
  } deriving Generic

type UserTable = UserTableT Identity

instance Beamable UserTableT
instance Beamable (PrimaryKey UserTableT)

instance Table UserTableT where
  data PrimaryKey UserTableT f = UserTableId (Columnar f Int) deriving Generic
  primaryKey = UserTableId . dbUserId

data GithubUserTableT f = GithubUserTable 
  { dbGithubUserId       :: Columnar f Int
  , dbGithubUserUsername :: Columnar f String
  , dbGithubUserUserId   :: PrimaryKey UserTableT f
  } deriving Generic

type GithubUserTable = GithubUserTableT Identity

instance Beamable GithubUserTableT
instance Beamable (PrimaryKey GithubUserTableT)

instance Table GithubUserTableT where
  data PrimaryKey GithubUserTableT f = GithubUserTableId (Columnar f Int) deriving Generic
  primaryKey = GithubUserTableId . dbGithubUserId

data DBMatchType = DBRockPaperScissorsMatch
                  deriving (Show, Enum, Read, Eq, Ord)

instance HasSqlEqualityCheck PgExpressionSyntax DBMatchType
instance HasSqlValueSyntax be String => HasSqlValueSyntax be DBMatchType where
  sqlValueSyntax = autoSqlValueSyntax

instance FromField DBMatchType where
  fromField _ (Just "DBRockPaperScissorsMatch") = return DBRockPaperScissorsMatch
  fromField _ val                               = fail ("Invalid value for DBMatchType " ++ show val)

instance (BeamBackend be, FromBackendRow be String) => FromBackendRow be DBMatchType where
  fromBackendRow = do
    val <- fromBackendRow
    case val :: String of
      "DBRockPaperScissorsMatch" -> pure DBRockPaperScissorsMatch
      _                          -> fail ("Invalid value for DBMatchType " ++ val)

data DBMatchStatus = DBMatchPending
                   | DBMatchInProgress
                   | DBMatchComplete
                   | DBMatchCancelled
                   deriving (Show, Enum, Read, Eq, Ord)

instance HasSqlEqualityCheck PgExpressionSyntax DBMatchStatus
instance HasSqlValueSyntax be String => HasSqlValueSyntax be DBMatchStatus where
  sqlValueSyntax = autoSqlValueSyntax

instance FromField DBMatchStatus where
  fromField _ (Just "DBMatchPending")    = return DBMatchPending
  fromField _ (Just "DBMatchInProgress") = return DBMatchInProgress
  fromField _ (Just "DBMatchComplete")   = return DBMatchComplete
  fromField _ (Just "DBMatchCancelled")  = return DBMatchCancelled
  fromField _ val                  = fail ("Invalid value for DBMatchStatus " ++ show val)

instance (BeamBackend be, FromBackendRow be String) => FromBackendRow be DBMatchStatus where
  fromBackendRow = do
    val <- fromBackendRow
    case val :: String of
      "DBMatchPending"    -> pure DBMatchPending
      "DBMatchInProgress" -> pure DBMatchInProgress
      "DBMatchComplete"   -> pure DBMatchComplete
      "DBMatchCancelled"  -> pure DBMatchCancelled
      _                   -> fail ("Invalid value for DBMatchStatus " ++ val)

data MatchTableT f = MatchTable
  { dbMatchId     :: Columnar f Int
  , dbMatchStatus :: Columnar f DBMatchStatus
  , dbMatchType   :: Columnar f DBMatchType  
  } deriving Generic

type MatchTable = MatchTableT Identity
deriving instance Show MatchTable
deriving instance Eq MatchTable

type MatchTableId = PrimaryKey MatchTableT Identity
deriving instance Eq MatchTableId

instance Beamable MatchTableT
instance Beamable (PrimaryKey MatchTableT)

instance Table MatchTableT where
  data PrimaryKey MatchTableT f = MatchTableId (Columnar f Int) deriving Generic
  primaryKey = MatchTableId . dbMatchId

data BotTableT f = BotTable
  { dbBotId                 :: Columnar f Int
  , dbBotGithubRepositoryId :: PrimaryKey GithubRepositoryTableT f
  , dbBotPath               :: Columnar f String
  } deriving Generic

type BotTable = BotTableT Identity
deriving instance Show BotTable
deriving instance Eq BotTable

type BotTableId = PrimaryKey BotTableT Identity
deriving instance Eq BotTableId

instance Beamable BotTableT
instance Beamable (PrimaryKey BotTableT)

instance Table BotTableT where
  data PrimaryKey BotTableT f = BotTableId (Columnar f Int) deriving Generic
  primaryKey = BotTableId . dbBotId

data MatchParticipationTableT f = MatchParticipationTable
  { dbMatchParticipationId      :: Columnar f Int
  , dbMatchParticipationBotId   :: PrimaryKey BotTableT f
  , dbMatchParticipationMatchId :: PrimaryKey MatchTableT f
  } deriving Generic

instance Beamable MatchParticipationTableT
instance Beamable (PrimaryKey MatchParticipationTableT)

instance Table MatchParticipationTableT where
  data PrimaryKey MatchParticipationTableT f = MatchParticipationTableId (Columnar f Int) deriving Generic
  primaryKey = MatchParticipationTableId . dbMatchParticipationId


data MmoaigAPIDatabase f = MmoaigAPIDatabase
  { dbUsers              :: f (TableEntity UserTableT)
  , dbGithubUsers        :: f (TableEntity GithubUserTableT)
  , dbGithubRepositories :: f (TableEntity GithubRepositoryTableT)
  , dbMatches            :: f (TableEntity MatchTableT)
  , dbMatchParticipation :: f (TableEntity MatchParticipationTableT)
  , dbBots               :: f (TableEntity BotTableT)
  } deriving Generic

instance Database be MmoaigAPIDatabase

mmoaigAPIDatabase :: DatabaseSettings be MmoaigAPIDatabase
mmoaigAPIDatabase = defaultDbSettings
