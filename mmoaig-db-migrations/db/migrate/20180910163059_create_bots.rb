class CreateBots < ActiveRecord::Migration[5.2]
  def change
    create_table :bots, {primary_key: :bot_id} do |t|
      t.integer :bot_github_repository_id__github_repository_id
      t.string :bot_path
    end
  end
end
