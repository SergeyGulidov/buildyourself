class AddColumnsToPlaces < ActiveRecord::Migration
  def change
    add_column :places, :translated, :integer, default: 0
    add_column :places, :training_time, :text
  end
end
