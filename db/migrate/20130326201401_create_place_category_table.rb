class CreatePlaceCategoryTable < ActiveRecord::Migration
  def up
  	create_table :places_category do |t|
  		t.integer :place_id
  		t.integer :category_id
  	end
  	add_index :places_category, :place_id
  	add_index :places_category, :category_id
  end

  def down
  end
end
