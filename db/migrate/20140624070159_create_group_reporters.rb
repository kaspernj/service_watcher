class CreateGroupReporters < ActiveRecord::Migration
  def change
    create_table :group_reporters do |t|
      t.integer :group_id
      t.integer :reporter_id
      t.timestamps
    end

    add_index :group_reporters, :group_id
    add_index :group_reporters, :reporter_id
  end
end
