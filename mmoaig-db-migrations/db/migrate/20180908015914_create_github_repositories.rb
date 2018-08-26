class CreateGithubRepositories < ActiveRecord::Migration[5.2]
  def change
    create_table :github_repositories, {primary_key: :github_repository_id} do |t|
      t.string :github_repository_name, unique: true, null: false
      t.integer :github_repository_github_user_id__github_user_id, null: false
    end
  end
end
