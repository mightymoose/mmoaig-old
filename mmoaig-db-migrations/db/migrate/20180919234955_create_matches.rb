class CreateMatches < ActiveRecord::Migration[5.2]
  def change 

    create_table :matches, {primary_key: :match_id} do |t|
      t.string :match_status
      t.string :match_type
    end

    execute <<-DDL
      ALTER TABLE matches ADD CONSTRAINT match_status_constraint CHECK (match_status IN (
        'DBMatchPending', 'DBMatchInProgress', 'DBMatchComplete', 'DBMatchCancelled'
      ));

      ALTER TABLE matches ADD CONSTRAINT match_type_constraint CHECK (match_type IN (
        'DBRockPaperScissorsMatch'
      ));
    DDL
  end

  def down
    execute "ALTER TABLE matches DROP CONSTRAINT match_status_constraint"
    execute "ALTER TABLE matches DROP CONSTRAINT match_type_constraint"
    drop_table :matches
  end
end
