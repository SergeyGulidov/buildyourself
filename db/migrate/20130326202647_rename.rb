class Rename < ActiveRecord::Migration
  def up
  	drop_table :categorization




  	create_table :categorizations do |t|
  		t.integer :type_id
  		t.integer :category_id
  		t.integer :place_id

  	
  	end
  	add_index :categorizations, :place_id
  	add_index :categorizations, :type_id
  	add_index :categorizations, :category_id
  end

  def down
  end
end
