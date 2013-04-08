class AddHitsToPlaces < ActiveRecord::Migration
  def change
    add_column :places, :hits, :integer, default: 0
  end
end
