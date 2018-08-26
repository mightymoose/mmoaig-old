class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users, {primary_key: :user_id} do |t|
      t.string :user_username, unique: true, null: false
      t.boolean :user_active, null: false
    end
  end
end
