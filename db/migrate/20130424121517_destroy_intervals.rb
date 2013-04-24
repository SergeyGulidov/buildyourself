class DestroyIntervals < ActiveRecord::Migration
  def up
  	drop_table :intervals
  	remove_column :categorizations, :interval_id
  	add_column    :places, :not_actual, :integer, default: 0  
  	add_column    :users,  :comments, :integer, default: 0
  end

  def down
  end
end
