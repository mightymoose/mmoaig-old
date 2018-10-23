class AddMostRecentMatchInstanceToMatches < ActiveRecord::Migration[5.2]
  def change
    add_column :matches, :match_most_recent_instance__match_instance_id, :integer
  end
end
