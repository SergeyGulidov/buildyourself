class DeleteTables < ActiveRecord::Migration
  def up
  	remove_column :places, :location_id
  	drop_table :location_translations
  	drop_table :locations
  	add_column :places, :city, :string
  end

  def down
  end
end
