class RemoveTypesFromPlaces < ActiveRecord::Migration
  def up
    remove_column :places, :type
  end

  def down
    add_column :places, :type, :string
  end
end
