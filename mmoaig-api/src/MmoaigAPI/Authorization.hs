module MmoaigAPI.Authorization where 

newtype AuthorizationTicketType = RockPaperScissorsMatchAuthorization Int

data AuthorizationTicket = AuthorizationTicket
  { authorizationTicketValid :: Bool
  , authorizationTicketType  :: AuthorizationTicketType
  }

grantTicket :: AuthorizationTicket
grantTicket = AuthorizationTicket True $ RockPaperScissorsMatchAuthorization 1
