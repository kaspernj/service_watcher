class ChangePluginToPluginIdOnServices < ActiveRecord::Migration
  def up
    add_column :services, :plugin_id, :integer
    add_index :services, :plugin_id
    remove_column :services, :plugin
  end

  def down
    remove_column :services, :plugin_id
    add_column :services, :plugin, :string
  end
end
