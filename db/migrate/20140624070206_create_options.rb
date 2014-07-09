class CreateOptions < ActiveRecord::Migration
  def change
    create_table :options do |t|
      t.string :resource_type
      t.integer :resource_id
      t.string :key
      t.text :value
      t.timestamps
    end

    add_index :options, [:resource_type, :resource_id]
  end
end
