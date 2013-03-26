class CreateCategoriesTable < ActiveRecord::Migration
  def up
  	create_table :categories do |t|
  		t.string :class 
  		t.string :slug
  	end

  	create_table :categorization do |t|
  		t.integer :type_id
  		t.integer :category_id
  	end

  	add_index :categorization, :type_id
  	add_index :categorization, :category_id

  	
  end

  def down
  end
end
