class AddCategoryIdToPlaces < ActiveRecord::Migration
  def change
    add_column :places, :category_id, :integer, default: 1
    add_column :places, :type_id, :integer, default: 1
    add_column :types,  :category_id, :integer, default: 1

    add_index :places, :category_id
    add_index :places, :type_id
    add_index :types,  :category_id
  end
end
