class CreateGithubUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :github_users, {primary_key: :github_user_id} do |t|
      t.string :github_user_username, unique: true, null: false
      t.integer :github_user_user_id__user_id, null: false
    end
  end
end
