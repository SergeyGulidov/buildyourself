class DropTypesTable < ActiveRecord::Migration
  def up
  	drop_table :types
  end

  def down
  end
end
