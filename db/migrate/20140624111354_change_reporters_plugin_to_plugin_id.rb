class ChangeReportersPluginToPluginId < ActiveRecord::Migration
  def up
    add_column :reporters, :reporter_plugin_id, :integer, :after => :plugin
    remove_column :reporters, :plugin
    add_index :reporters, :reporter_plugin_id
  end
  
  def down
    add_column :reporters, :plugin, :string
    remove_column :reporters, :reporter_plugin_id
  end
end
