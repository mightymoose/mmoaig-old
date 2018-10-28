class CreateBots < ActiveRecord::Migration[5.2]
  def change
    create_table :bots, {primary_key: :bot_id} do |t|
      t.integer :bot_github_repository_id__github_repository_id
      t.string :bot_path
      t.column :bot_created_at, 'timestamp with time zone'
      t.column :bot_updated_at, 'timestamp with time zone'
    end
  end
end
