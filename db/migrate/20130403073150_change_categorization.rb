class ChangeCategorization < ActiveRecord::Migration
  def up
  	remove_column :categorizations, :location_id
  	drop_table :locations
  	drop_table :roles
  end

  def down
  end
end
