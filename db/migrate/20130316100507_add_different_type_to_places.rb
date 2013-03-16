class AddDifferentTypeToPlaces < ActiveRecord::Migration
  def change
  	add_column :places, :different_type, :boolean
  end
end
