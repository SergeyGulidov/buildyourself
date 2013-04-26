class AddCounterToTables < ActiveRecord::Migration
  def up
  	add_column :types, :count_all, :integer, default: 0
  	add_column :categories, :count_all, :integer, default: 0
  	add_column :cities, :count_all, :integer, default: 0

  	add_index :types, :count_all
  	add_index :categories, :count_all
  	add_index :cities, :count_all

  end	
  def down
  	
  end
end
