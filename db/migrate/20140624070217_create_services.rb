class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.string :name
      t.string :plugin
      t.integer :timeout
      t.datetime :last_run_at
      t.integer :group_id
      t.boolean :failed
      t.timestamps
    end
    
    add_index :services, :group_id
  end
end
