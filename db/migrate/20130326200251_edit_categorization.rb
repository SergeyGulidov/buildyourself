class EditCategorization < ActiveRecord::Migration
  def up
  	add_column :categorization, :place_id, :integer

  	add_index :categorization, :place_id
  end

  def down
  end
end
