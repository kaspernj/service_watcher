class AddActiveToServices < ActiveRecord::Migration
  def change
    add_column :services, :active, :boolean, :after => :group_id
    add_index :services, :active
  end
end
