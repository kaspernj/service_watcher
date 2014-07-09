class CreateReporterPlugins < ActiveRecord::Migration
  def change
    create_table :reporter_plugins do |t|
      t.string :name
      t.timestamps
    end

    add_index :reporter_plugins, :name
  end
end
