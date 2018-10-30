fake_timestamp = Date.parse('April 15, 1707')
class Bot < ActiveRecord::Base
end

class User < ActiveRecord::Base
end

class GithubRepository < ActiveRecord::Base
end

class GithubUser < ActiveRecord::Base
end

class Match < ActiveRecord::Base
end

class MatchParticipation < ActiveRecord::Base
  self.table_name = "match_participation"
end

class MatchInstance < ActiveRecord::Base
end

class RockPaperScissorsRound < ActiveRecord::Base
end

puts "Checking for the initial users..."
existing_user_count = User.count

if existing_user_count == 0
  puts "No users found - adding the initial users"

  User.create(user_username: 'MightyMoose', user_active: true, user_created_at: fake_timestamp, user_updated_at: fake_timestamp)
  (2..100).each { |user_number| User.create(user_username: "User ##{user_number}", user_active: false, user_created_at: fake_timestamp, user_updated_at: fake_timestamp) }

  puts "Created users:"
  User.all.each { |user| puts "  - #{user.user_username}" }
else
  puts "Users found - skipping adding initial users"
end

puts "Checking for the initial github users..."
existing_github_user_count = GithubUser.count

if existing_github_user_count == 0
  puts "No github users found - adding the initial github users"

  GithubUser.create(github_user_username: 'mightymoose', github_user_user_id__user_id: 1, github_user_created_at: fake_timestamp, github_user_updated_at: fake_timestamp)
  (2..100).each { |user_number| GithubUser.create(github_user_username: "github_user ##{user_number}", github_user_user_id__user_id: user_number, github_user_created_at: fake_timestamp, github_user_updated_at: fake_timestamp) }

  puts "Created github users:"
  GithubUser.all.each { |user| puts "  - #{user.github_user_username}" }
else
  puts "Github users found - skipping adding initial github users"
end

puts "Checking for the initial github repositories..."
existing_github_repository_count = GithubRepository.count

if existing_github_repository_count == 0
  puts "No github repositories found - adding the github repositories..."

  GithubRepository.create(github_repository_name: 'bots', github_repository_github_user_id__github_user_id: 1, github_repository_created_at: fake_timestamp, github_repository_updated_at: fake_timestamp)
  (2..100).each do |repository_number| 
    GithubRepository.create(github_repository_name: "fake_repo ##{repository_number}", github_repository_github_user_id__github_user_id: repository_number, github_repository_created_at: fake_timestamp, github_repository_updated_at: fake_timestamp)
  end

  puts "Created users:"
  GithubRepository.all.each { |repository| puts "  - #{repository.github_repository_name}" }
else
  puts "Github repositories found - skipping adding initial repositories"
end

puts "Checking for the initial bots..."
existing_bot_count = Bot.count

if existing_bot_count == 0
  puts "No bots found - adding the initial bots"

  Bot.create(bot_github_repository_id__github_repository_id: 1, bot_path: 'rock-paper-scissors/rock-bot.js', bot_created_at: fake_timestamp, bot_updated_at: fake_timestamp)
  Bot.create(bot_github_repository_id__github_repository_id: 1, bot_path: 'rock-paper-scissors/paper-bot.js', bot_created_at: fake_timestamp, bot_updated_at: fake_timestamp)
  Bot.create(bot_github_repository_id__github_repository_id: 1, bot_path: 'rock-paper-scissors/scissors-bot.js', bot_created_at: fake_timestamp, bot_updated_at: fake_timestamp)
  (4..100).each { |bot_number| Bot.create(bot_github_repository_id__github_repository_id: bot_number, bot_path: "bot_path ##{bot_number}", bot_created_at: fake_timestamp, bot_updated_at: fake_timestamp) }

  puts "Created bots:"
  Bot.all.each { |bot| puts "  - #{bot.bot_path}" }
else
  puts "Bots found - skipping adding initial bots"
end

puts "Checking for the initial matches..."
existing_match_count = Match.count

if existing_match_count == 0
  puts "No match found - adding the initial matches"

  Match.create(match_status: 'DBMatchPending', match_type: 'DBRockPaperScissorsMatch', match_created_at: fake_timestamp, match_updated_at: fake_timestamp)
  Match.create(match_status: 'DBMatchInProgress', match_type: 'DBRockPaperScissorsMatch', match_created_at: fake_timestamp, match_updated_at: fake_timestamp)
  Match.create(match_status: 'DBMatchComplete', match_type: 'DBRockPaperScissorsMatch', match_created_at: fake_timestamp, match_updated_at: fake_timestamp)
  (4..100).each { |match_number| Match.create(match_status: 'DBMatchCancelled', match_type: 'DBRockPaperScissorsMatch', match_created_at: fake_timestamp, match_updated_at: fake_timestamp) }

  puts "Created matches:"
  Match.all.each { |match| puts "  - #{match.match_id}" }
else
  puts "Matches found - skipping adding initial matches"
end

puts "Checking for the initial participation..."
existing_match_participation_count = MatchParticipation.count

if existing_match_participation_count == 0
  puts "No match participants found - adding the initial match participation"

  MatchParticipation.create(match_participation_bot_id__bot_id: 2, match_participation_match_id__match_id: 1, match_participation_created_at: fake_timestamp, match_participation_updated_at: fake_timestamp)
  MatchParticipation.create(match_participation_bot_id__bot_id: 3, match_participation_match_id__match_id: 1, match_participation_created_at: fake_timestamp, match_participation_updated_at: fake_timestamp)
  (2..100).each do |match_number| 
    MatchParticipation.create(match_participation_bot_id__bot_id: 1, match_participation_match_id__match_id: match_number, match_participation_created_at: fake_timestamp, match_participation_updated_at: fake_timestamp)
    MatchParticipation.create(match_participation_bot_id__bot_id: 1, match_participation_match_id__match_id: match_number, match_participation_created_at: fake_timestamp, match_participation_updated_at: fake_timestamp)
  end

  puts "Created match participation:"
  MatchParticipation.all.each { |participation| puts "  - #{participation.match_participation_id}" }
else
  puts "Match participation found - skipping adding initial match participation"
end

puts "Checking for the initial match instances..."
existing_match_instance_count = MatchInstance.count

if existing_match_instance_count == 0
  puts "No match instances found - adding the initial match instances"

  (1..100).each do |match_instance_number| 
    MatchInstance.create(match_instance_token: "match #{match_instance_number} token", match_instance_match_id__match_id: 2 + (match_instance_number % 3), match_instance_created_at: fake_timestamp, match_instance_updated_at: fake_timestamp)
  end

  puts "Created match instance:"
  MatchInstance.all.each { |instance| puts "  - #{instance.match_instance_id}" }
else
  puts "Match instances found - skipping adding initial match instances"
end

puts "Checking for the initial rock paper scissors rounds instances..."
puts RockPaperScissorsRound
existing_rock_paper_scissors_round_instance_count = RockPaperScissorsRound.count

if existing_rock_paper_scissors_round_instance_count == 0
  puts "No match rock paper scissors rounds found - adding the initial rock paper scissors rounds"

  (1..100).each do |rock_paper_scissors_round_number| 
    RockPaperScissorsRound.create(
      rock_paper_scissors_round_number: 1,
      rock_paper_scissors_match_instance_id__match_instance_id: rock_paper_scissors_round_number,
      rock_paper_scissors_first_player_throw: "DBRockPaperScissorsRock",
      rock_paper_scissors_second_player_throw: "DBRockPaperScissorsRock",
      rock_paper_scissors_round_winner__match_participation_id: 1,
      rock_paper_scissors_round_created_at: fake_timestamp,
      rock_paper_scissors_round_updated_at: fake_timestamp
    )
  end

  puts "Created rock paper scissors round:"
  RockPaperScissorsRound.all.each { |instance| puts "  - #{instance.rock_paper_scissors_round_id}" }
else
  puts "Rock paper scissors rounds found - skipping adding initial rock paper scissors rounds"
end
