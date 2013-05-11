class AddCountToCities < ActiveRecord::Migration
  def change
    add_column :cities,     :places_count, :integer, default: 0
    add_column :countries,  :places_count, :integer, default: 0
    add_column :types,      :places_count, :integer, default: 0
    add_column :categories, :places_count, :integer, default: 0

    drop_table :categorizations
  end
end
