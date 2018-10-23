class CreateMatchInstances < ActiveRecord::Migration[5.2]
  def change
    create_table :match_instances, {primary_key: :match_instance_id} do |t|
      t.string :match_instance_token, unique: true, null: false
      t.integer :match_instance_match_id__match_id, null: false
    end
  end
end