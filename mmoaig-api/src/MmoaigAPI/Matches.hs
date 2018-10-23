module MmoaigAPI.Matches (loadMatchList, loadMatchDetails, updateMatch, loadNextMatch) where

import Database.PostgreSQL.Simple (Connection)
import Control.Monad.IO.Class (liftIO)
import Database.Beam.Postgres (runBeamPostgres)
import Database.Beam (orderBy_, asc_, lookup_, runSelectReturningOne, runSelectReturningList, select, all_, limit_, related_, val_, (==.), guard_, runUpdate, update, (<-.))

import MmoaigAPI.Schema (MatchInstanceTable, DBMatchStatus(DBMatchPending, DBMatchInProgress), MatchTable, dbMatches, mmoaigAPIDatabase, BotTable, dbMatchParticipationBotId, dbMatchParticipationMatchId, dbMatchParticipation, dbBots, dbMatchId, dbMatchStatus, PrimaryKey(MatchTableId))
import MmoaigAPI.MatchInstances (createMatchInstanceForMatch)

loadMatchDetails :: Int -> Connection -> IO (Maybe (MatchTable, [BotTable]))
loadMatchDetails matchId connection = fmap formatMatchDetails (loadMatchParticipation matchId connection)

formatMatchDetails :: [(MatchTable, BotTable)] -> Maybe (MatchTable, [BotTable])
formatMatchDetails [] = Nothing
formatMatchDetails details = Just (match, participants)
  where
    match = fst $ head details
    participants = map snd details

loadMatchParticipation :: Int -> Connection -> IO [(MatchTable, BotTable)]
loadMatchParticipation matchId connection = 
  liftIO $ runBeamPostgres connection $
    runSelectReturningList $ select $ do
      participation <- all_ (dbMatchParticipation mmoaigAPIDatabase)
      bots <- related_ (dbBots mmoaigAPIDatabase) (dbMatchParticipationBotId participation)
      matches <- related_ (dbMatches mmoaigAPIDatabase) (dbMatchParticipationMatchId participation)
      guard_ (dbMatchId matches ==. val_ matchId)
      pure (matches, bots)
      

loadMatchList :: Connection -> IO [MatchTable]
loadMatchList connection =
  liftIO $ runBeamPostgres connection $
    runSelectReturningList $ select $ limit_ 25 $ orderBy_ (asc_ . dbMatchId) $
      all_ (dbMatches mmoaigAPIDatabase)

updateMatch :: Int -> DBMatchStatus -> Connection -> IO (Maybe MatchTable)
updateMatch matchId status connection =
  liftIO $ runBeamPostgres connection $ do
    runUpdate $ update (dbMatches mmoaigAPIDatabase) 
      (\c -> [ dbMatchStatus c <-. val_ status ])
      (\c -> dbMatchId c ==. val_ matchId)
    runSelectReturningOne $ lookup_ (dbMatches mmoaigAPIDatabase) (MatchTableId matchId)

loadNextMatch :: Connection -> IO (Maybe (MatchTable, [BotTable], MatchInstanceTable))
loadNextMatch connection = do
  pendingMatch <- liftIO $ runBeamPostgres connection $
    runSelectReturningList $ select $ limit_ 1 $ orderBy_ (asc_ . dbMatchId) $ do
      matches <- all_ (dbMatches mmoaigAPIDatabase)
      guard_ (dbMatchStatus matches ==. val_ DBMatchPending)
      pure matches
  case pendingMatch of 
    [x] -> do
      let matchId = dbMatchId x
      Just (match, bots) <- loadMatchDetails (dbMatchId x) connection
      _ <- updateMatch matchId DBMatchInProgress connection
      matchInstance <- createMatchInstanceForMatch (dbMatchId x) connection
      return $ Just (match, bots, matchInstance)
    _   -> return Nothing
