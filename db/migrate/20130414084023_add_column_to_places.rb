class AddColumnToPlaces < ActiveRecord::Migration
  def change
    add_column :places, :month_price, :float
  end
end
