class CreateMatchInstances < ActiveRecord::Migration[5.2]
  def change
    create_table :match_instances, {primary_key: :match_instance_id} do |t|
      t.integer :match_instance_match_id__match_id, null: false
      t.column :match_instance_created_at, 'timestamp with time zone'
      t.column :match_instance_updated_at, 'timestamp with time zone'
    end
  end
end
