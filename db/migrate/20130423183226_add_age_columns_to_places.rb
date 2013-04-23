class AddAgeColumnsToPlaces < ActiveRecord::Migration
  def change
  	add_column :places, :age_min, :integer
  	add_column :places, :age_max, :integer
  	add_index  :places, :age_min
  	add_index  :places, :age_max
  end
end
