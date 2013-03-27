class Ups < ActiveRecord::Migration
  def up
  	remove_column :places, :approved
  	add_column :places, :approved, :integer, default: 0
  end

  def down
  end
end
