module MmoaigAPI.Games.RockPaperScissors ( addRound
                                         , createFirstPastThePostMatch
                                         , firstPlayerScore
                                         , matchScore
                                         , matchWinner
                                         , Player(FirstPlayer, SecondPlayer)
                                         , Round(Round)
                                         , secondPlayerScore
                                         , Throw(Rock, Paper, Scissors)
                                         ) where

import Prelude hiding (round)
import Data.Maybe (isJust)

data Throw = Rock | Paper | Scissors deriving (Show)

data Player = FirstPlayer | SecondPlayer deriving (Eq, Show)

data Round = Round
  { firstPlayerThrow  :: Throw
  , secondPlayerThrow :: Throw
  } deriving (Show)

data Match = Match
  { rounds       :: [Round]
  , winCondition :: WinCondition
  } deriving (Show)

newtype WinCondition = FirstPastThePost Int deriving (Show)

beats :: Throw -> Throw -> Bool
Rock     `beats` Scissors = True
Paper    `beats` Rock     = True
Scissors `beats` Paper    = True
_        `beats` _        = False

roundWinner :: Round -> Maybe Player
roundWinner (Round a b)
  | a `beats` b = Just FirstPlayer
  | b `beats` a = Just SecondPlayer
  | otherwise   = Nothing

data MatchScore = MatchScore
  { firstPlayerScore  :: Int
  , secondPlayerScore :: Int
  }

matchScore :: Match -> MatchScore
matchScore match = MatchScore (scoreFor FirstPlayer) (scoreFor SecondPlayer)
  where
    scoreFor = length . winsForPlayer
    winsForPlayer player = filter (wonByPlayer player) (rounds match)
    wonByPlayer player round = roundWinner round == Just player

createFirstPastThePostMatch :: Int -> Either String Match
createFirstPastThePostMatch matchLength
  | matchLength > 0 = Right $ Match [] (FirstPastThePost matchLength)
  | otherwise       = Left "The length of a first past the post match must be greater than 0."

matchWinner :: Match -> Maybe Player
matchWinner match@(Match _ (FirstPastThePost matchLength))
    | firstPlayerScore (matchScore match) >= matchLength  = Just FirstPlayer
    | secondPlayerScore (matchScore match) >= matchLength = Just SecondPlayer
    | otherwise = Nothing

matchComplete :: Match -> Bool
matchComplete match@(Match _ (FirstPastThePost _)) = isJust $ matchWinner match

addRound :: Round -> Match -> Either String Match
addRound round match
  | matchComplete match = Left "A round cannot be added to a completed match."
  | otherwise           = Right $ match { rounds = round : rounds match }

