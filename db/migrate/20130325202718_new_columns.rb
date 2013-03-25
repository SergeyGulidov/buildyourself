class NewColumns < ActiveRecord::Migration
  def up
  	remove_column :assignments, :location_id, :integer
  	add_column :places, :city, :string

  	drop_table :locations
  	drop_table :location_translations
  end

  def down
  end
end
