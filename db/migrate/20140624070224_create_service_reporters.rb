class CreateServiceReporters < ActiveRecord::Migration
  def change
    create_table :service_reporters do |t|
      t.integer :service_id
      t.integer :reporter_id
      t.timestamps
    end

    add_index :service_reporters, :service_id
    add_index :service_reporters, :reporter_id
  end
end
