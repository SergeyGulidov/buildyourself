class AddIndexesAndChangeType < ActiveRecord::Migration
  def up
  	remove_column :places, :manytypes
  	add_column :places, :comment, :text
  	drop_table :places_category
  	drop_table :assignments

  	add_index :categorizations, :interval_id
  	add_index :categorizations, :location_id

  	add_index :categories, :category_slug
  	add_index :intervals, :interval_slug
  	add_index :types, :type_slug
  	add_index :locations, :location_slug

  end

  def down
  end
end
