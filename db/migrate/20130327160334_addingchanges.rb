class Addingchanges < ActiveRecord::Migration
  def up
  	drop_table :age_categories

  	create_table :intervals do |t|
  		t.string :interval_name
  		t.string :interval_slug 
  	end

  	remove_column :categories, :slug
  	add_column :categories, :category_slug, :string

  	remove_column :types, :slug
  	add_column :types, :type_slug, :string

  	remove_column :categorizations, :age_category_id
  	add_column :categorizations, :interval_id, :integer

  end

  def down
  end
end
