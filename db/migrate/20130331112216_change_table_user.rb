class ChangeTableUser < ActiveRecord::Migration
  def up
  	remove_column :users, :role
  	add_column :users, :role, :integer, default: 2
  end

  def down
  end
end
