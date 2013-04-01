class RemoveRoles < ActiveRecord::Migration
  def up
  	remove_column :users, :role_id
  end

  def down
  end
end
