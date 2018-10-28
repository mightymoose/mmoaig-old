class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users, {primary_key: :user_id} do |t|
      t.string :user_username, unique: true, null: false
      t.boolean :user_active, null: false
      t.column :user_created_at, 'timestamp with time zone'
      t.column :user_updated_at, 'timestamp with time zone'
    end
  end
end
