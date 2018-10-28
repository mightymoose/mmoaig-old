class CreateRockPaperScissorsRounds < ActiveRecord::Migration[5.2]
  def change
    create_table :rock_paper_scissors_rounds, {primary_key: :rock_paper_scissors_round_id} do |t|
      t.integer :rock_paper_scissors_round_number
      t.integer :rock_paper_scissors_match_instance_id__match_instance_id
      t.string :rock_paper_scissors_first_player_throw
      t.string :rock_paper_scissors_second_player_throw
      t.string :rock_paper_scissors_round_winner
      t.integer :rock_paper_scissors_round_winner__match_participation_id
      t.column :rock_paper_scissors_round_created_at, 'timestamp with time zone'
      t.column :rock_paper_scissors_round_updated_at, 'timestamp with time zone'
    end

    execute <<-DDL
      ALTER TABLE rock_paper_scissors_rounds ADD CONSTRAINT rps_first_player_throw_constraint CHECK (rock_paper_scissors_first_player_throw IN (
        'DBRockPaperScissorsRock', 'DBRockPaperScissorsPaper', 'DBRockPaperScissorsScissors'
      ));

      ALTER TABLE rock_paper_scissors_rounds ADD CONSTRAINT rps_second_player_throw_constraint CHECK (rock_paper_scissors_second_player_throw IN (
        'DBRockPaperScissorsRock', 'DBRockPaperScissorsPaper', 'DBRockPaperScissorsScissors'
      ));

    DDL
  end

  def down
    execute "ALTER TABLE matches DROP CONSTRAINT rps_first_player_throw_constraint"
    execute "ALTER TABLE matches DROP CONSTRAINT rps_second_player_throw_constraint"
    drop_table :rock_paper_scissors_rounds
  end
end
