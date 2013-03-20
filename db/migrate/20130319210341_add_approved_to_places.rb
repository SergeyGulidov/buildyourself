class AddApprovedToPlaces < ActiveRecord::Migration
  def change
  	remove_column :places, :approved, :boolean
    add_column :places, :approved, :boolean, default: false
  end
end
