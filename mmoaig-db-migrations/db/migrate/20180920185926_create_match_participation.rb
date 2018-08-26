class CreateMatchParticipation < ActiveRecord::Migration[5.2]
  def change
    create_table :match_participation, {primary_key: :match_participation_id} do |t|
      t.integer :match_participation_bot_id__bot_id
      t.integer :match_participation_match_id__match_id
    end
  end
end
