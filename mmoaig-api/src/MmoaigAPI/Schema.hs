{-# LANGUAGE DeriveGeneric         #-}
{-# LANGUAGE TypeFamilies          #-}
{-# LANGUAGE FlexibleInstances     #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE UndecidableInstances  #-}
{-# LANGUAGE OverloadedStrings     #-}
{-# LANGUAGE StandaloneDeriving    #-}
module MmoaigAPI.Schema ( UserTableT(UserTable)
                        , RockPaperScissorsRoundTableT(RockPaperScissorsRoundTable)
                        , UserTable
                        , EmailAndPasswordTable
                        , BotTableT(BotTable)
                        , BotTable
                        , GithubUserTableT(GithubUserTable)
                        , MatchTableT(MatchTable)
                        , dbMatchParticipationBotId
                        , dbMatchParticipationMatchId
                        , GithubUserTable
                        , MatchParticipationTable
                        , MatchParticipationTableT(MatchParticipationTable)
                        , MatchInstanceTableT(MatchInstanceTable)
                        , MatchInstanceTable
                        , dbMatchParticipationId
                        , dbGithubUserId
                        , dbGithubUserUsername
                        , dbGithubUserUserId
                        , dbGithubUserCreatedAt
                        , dbGithubUserUpdatedAt
                        , dbGithubUsers
                        , dbUsers
                        , RockPaperScissorsRoundTable
                        , dbMatchInstances
                        , dbMatchInstanceId
                        , dbUserCreatedAt
                        , dbUserUpdatedAt
                        , dbGithubRepositoryCreatedAt
                        , dbGithubRepositoryUpdatedAt
                        , dbMatchInstanceToken
                        , dbMatchInstanceMatchId
                        , dbBots
                        , dbGithubRepositories
                        , mmoaigAPIDatabase
                        , dbUserId
                        , dbBotId
                        , dbBotGithubRepositoryId
                        , dbBotPath
                        , dbBotCreatedAt
                        , dbBotUpdatedAt
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
                        , dbMatchParticipationCreatedAt
                        , dbMatchParticipationUpdatedAt
                        , dbMatchId
                        , MatchTableId
                        , PrimaryKey(MatchTableId, BotTableId, GithubUserTableId, GithubRepositoryTableId , MatchParticipationTableId, MatchInstanceTableId, UserTableId)
                        , MatchTable
                        , dbMatchStatus
                        , dbMatchInstanceCreatedAt
                        , dbMatchInstanceUpdatedAt
                        , dbMatchType
                        , dbMatchCreatedAt
                        , dbMatchUpdatedAt
                        , DBMatchStatus(DBMatchPending, DBMatchInProgress
                        , DBMatchComplete
                        , DBMatchCancelled)
                        , dbRockPaperScissorsRounds
                        , dbRockPaperScissorsRoundId
                        , dbRockPaperScissorsMatchInstanceId
                        , dbRockPaperScissorsRoundWinner
                        , dbRockPaperScissorsRoundCreatedAt
                        , dbRockPaperScissorsRoundUpdatedAt
                        , dbRockPaperScissorsRoundNumber
                        , dbRockPaperScissorsFirstPlayerThrow
                        , dbRockPaperScissorsSecondPlayerThrow
                        , MatchParticipationTableId
                        , DBRockPaperScissorsThrow(DBRockPaperScissorsRock, DBRockPaperScissorsPaper, DBRockPaperScissorsScissors)
                        ) where

import Database.PostgreSQL.Simple.FromField (FromField, fromField)
import Database.Beam.Postgres.Syntax (PgExpressionSyntax)
import Database.Beam.Backend.SQL (HasSqlValueSyntax, sqlValueSyntax, autoSqlValueSyntax, BeamBackend)
import Data.Time (LocalTime)

import Database.Beam ( TableEntity
                     , Beamable
                     , FromBackendRow
                     , fromBackendRow
                     , Nullable
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

data DBRockPaperScissorsThrow = DBRockPaperScissorsRock
                              | DBRockPaperScissorsPaper
                              | DBRockPaperScissorsScissors
                              deriving (Show, Enum, Read, Eq, Ord)

instance HasSqlEqualityCheck PgExpressionSyntax DBRockPaperScissorsThrow
instance HasSqlValueSyntax be String => HasSqlValueSyntax be DBRockPaperScissorsThrow where
  sqlValueSyntax = autoSqlValueSyntax

instance FromField DBRockPaperScissorsThrow where
  fromField _ (Just "DBRockPaperScissorsRock")     = return DBRockPaperScissorsRock
  fromField _ (Just "DBRockPaperScissorsPaper")    = return DBRockPaperScissorsPaper
  fromField _ (Just "DBRockPaperScissorsScissors") = return DBRockPaperScissorsScissors
  fromField _ val                                  = fail ("Invalid value for DBRockPaperScissorsThrow " ++ show val)

instance (BeamBackend be, FromBackendRow be String) => FromBackendRow be DBRockPaperScissorsThrow where
  fromBackendRow = do
    val <- fromBackendRow
    case val :: String of
      "DBRockPaperScissorsRock"     -> pure DBRockPaperScissorsRock
      "DBRockPaperScissorsPaper"    -> pure DBRockPaperScissorsPaper
      "DBRockPaperScissorsScissors" -> pure DBRockPaperScissorsScissors
      _                             -> fail ("Invalid value for DBRockPaperScissorsThrow " ++ val)

data RockPaperScissorsRoundTableT f = RockPaperScissorsRoundTable
  { dbRockPaperScissorsRoundId           :: Columnar f Int
  , dbRockPaperScissorsRoundNumber       :: Columnar f Int
  , dbRockPaperScissorsMatchInstanceId   :: PrimaryKey MatchInstanceTableT f
  , dbRockPaperScissorsFirstPlayerThrow  :: Columnar f DBRockPaperScissorsThrow
  , dbRockPaperScissorsSecondPlayerThrow :: Columnar f DBRockPaperScissorsThrow
  , dbRockPaperScissorsRoundWinner       :: PrimaryKey MatchParticipationTableT f
  , dbRockPaperScissorsRoundCreatedAt    :: Columnar f LocalTime
  , dbRockPaperScissorsRoundUpdatedAt    :: Columnar f LocalTime
  } deriving Generic

type RockPaperScissorsRoundTable = RockPaperScissorsRoundTableT Identity

type RockPaperScissorsRoundTableId = PrimaryKey RockPaperScissorsRoundTableT Identity
deriving instance Eq RockPaperScissorsRoundTableId

instance Beamable RockPaperScissorsRoundTableT
instance Beamable (PrimaryKey RockPaperScissorsRoundTableT)

instance Table RockPaperScissorsRoundTableT where
  data PrimaryKey RockPaperScissorsRoundTableT f = RockPaperScissorsRoundTableId (Columnar f Int) deriving Generic
  primaryKey = RockPaperScissorsRoundTableId . dbRockPaperScissorsRoundId

deriving instance Show (PrimaryKey RockPaperScissorsRoundTableT Identity)

data MatchInstanceTableT f = MatchInstanceTable
  { dbMatchInstanceId        :: Columnar f Int
  , dbMatchInstanceToken     :: Columnar f String
  , dbMatchInstanceMatchId   :: PrimaryKey MatchTableT f 
  , dbMatchInstanceCreatedAt :: Columnar f LocalTime
  , dbMatchInstanceUpdatedAt :: Columnar f LocalTime
  } deriving Generic

type MatchInstanceTable = MatchInstanceTableT Identity

type MatchInstanceTableId = PrimaryKey MatchInstanceTableT Identity
deriving instance Eq MatchInstanceTableId

instance Beamable MatchInstanceTableT
instance Beamable (PrimaryKey MatchInstanceTableT)

instance Table MatchInstanceTableT where
  data PrimaryKey MatchInstanceTableT f = MatchInstanceTableId (Columnar f Int) deriving Generic
  primaryKey = MatchInstanceTableId . dbMatchInstanceId

deriving instance Show (PrimaryKey MatchInstanceTableT Identity)

data GithubRepositoryTableT f = GithubRepositoryTable
  { dbGithubRepositoryId           :: Columnar f Int
  , dbGithubRepositoryName         :: Columnar f String
  , dbGithubRepositoryGithubUserId :: PrimaryKey GithubUserTableT f
  , dbGithubRepositoryCreatedAt    :: Columnar f LocalTime
  , dbGithubRepositoryUpdatedAt    :: Columnar f LocalTime
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
  { dbUserId        :: Columnar f Int
  , dbUserUsername  :: Columnar f String
  , dbUserActive    :: Columnar f Bool
  , dbUserCreatedAt :: Columnar f LocalTime
  , dbUserUpdatedAt :: Columnar f LocalTime
  } deriving Generic

type UserTable = UserTableT Identity

instance Beamable UserTableT
instance Beamable (PrimaryKey UserTableT)

instance Table UserTableT where
  data PrimaryKey UserTableT f = UserTableId (Columnar f Int) deriving Generic
  primaryKey = UserTableId . dbUserId

data EmailAndPasswordTableT f = EmailAndPasswordTable
  { dbEmailAndPasswordId           :: Columnar f Int
  , dbEmailAndPasswordEmail        :: Columnar f String
  , dbEmailAndPasswordPasswordHash :: Columnar f String
  , dbEmailAndPasswordActive       :: Columnar f Bool
  , dbEmailAndPasswordUserId       :: PrimaryKey UserTableT f
  , dbEmailAndPasswordCreatedAt    :: Columnar f LocalTime
  , dbEmailAndPasswordUpdatedAt    :: Columnar f LocalTime
  } deriving Generic

type EmailAndPasswordTable = EmailAndPasswordTableT Identity

instance Beamable EmailAndPasswordTableT
instance Beamable (PrimaryKey EmailAndPasswordTableT)

instance Table EmailAndPasswordTableT where
  data PrimaryKey EmailAndPasswordTableT f = EmailAndPasswordTableId (Columnar f Int) deriving Generic
  primaryKey = EmailAndPasswordTableId . dbEmailAndPasswordId

data GithubUserTableT f = GithubUserTable 
  { dbGithubUserId        :: Columnar f Int
  , dbGithubUserUsername  :: Columnar f String
  , dbGithubUserUserId    :: PrimaryKey UserTableT f
  , dbGithubUserCreatedAt :: Columnar f LocalTime
  , dbGithubUserUpdatedAt :: Columnar f LocalTime
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
  fromField _ val                        = fail ("Invalid value for DBMatchStatus " ++ show val)

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
  { dbMatchId                 :: Columnar f Int
  , dbMatchStatus             :: Columnar f DBMatchStatus
  , dbMatchType               :: Columnar f DBMatchType  
  , dbMatchCreatedAt          :: Columnar f LocalTime
  , dbMatchUpdatedAt          :: Columnar f LocalTime
  } deriving Generic

type MatchTable = MatchTableT Identity
deriving instance Show MatchTable
deriving instance Show (PrimaryKey MatchInstanceTableT (Nullable Identity))

deriving instance Eq MatchTable
deriving instance Eq (PrimaryKey MatchInstanceTableT (Nullable Identity))

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
  , dbBotCreatedAt          :: Columnar f LocalTime
  , dbBotUpdatedAt          :: Columnar f LocalTime
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
  { dbMatchParticipationId        :: Columnar f Int
  , dbMatchParticipationBotId     :: PrimaryKey BotTableT f
  , dbMatchParticipationMatchId   :: PrimaryKey MatchTableT f
  , dbMatchParticipationCreatedAt :: Columnar f LocalTime
  , dbMatchParticipationUpdatedAt :: Columnar f LocalTime
  } deriving Generic

type MatchParticipationTable = MatchParticipationTableT Identity

instance Beamable MatchParticipationTableT
instance Beamable (PrimaryKey MatchParticipationTableT)

type MatchParticipationTableId = PrimaryKey MatchParticipationTableT Identity
instance Table MatchParticipationTableT where
  data PrimaryKey MatchParticipationTableT f = MatchParticipationTableId (Columnar f Int) deriving Generic
  primaryKey = MatchParticipationTableId . dbMatchParticipationId


data MmoaigAPIDatabase f = MmoaigAPIDatabase
  { dbUsers                   :: f (TableEntity UserTableT)
  , dbGithubUsers             :: f (TableEntity GithubUserTableT)
  , dbEmailsAndPasswords      :: f (TableEntity EmailAndPasswordTableT)
  , dbGithubRepositories      :: f (TableEntity GithubRepositoryTableT)
  , dbMatches                 :: f (TableEntity MatchTableT)
  , dbMatchParticipation      :: f (TableEntity MatchParticipationTableT)
  , dbBots                    :: f (TableEntity BotTableT)
  , dbMatchInstances          :: f (TableEntity MatchInstanceTableT)
  , dbRockPaperScissorsRounds :: f (TableEntity RockPaperScissorsRoundTableT)
  } deriving Generic

instance Database be MmoaigAPIDatabase

mmoaigAPIDatabase :: DatabaseSettings be MmoaigAPIDatabase
mmoaigAPIDatabase = defaultDbSettings
