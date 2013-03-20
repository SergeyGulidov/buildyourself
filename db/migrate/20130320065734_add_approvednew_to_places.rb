class AddApprovednewToPlaces < ActiveRecord::Migration
  def change
  	remove_column :places, :approved
    add_column :places, :approved, :integer, default: 0
  end
end
