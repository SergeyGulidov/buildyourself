class AddIndexToAssignments < ActiveRecord::Migration
  def change
  	add_index :assignments, :place_id
  	add_index :assignments, :type_id
  end
end
