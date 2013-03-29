class DeleteUnwanted < ActiveRecord::Migration
  def up
  	remove_column :places, :city_lv
  	remove_column :places, :city_ru
  	remove_column :places, :country_ru
  	remove_column :places, :country_lv
  end

  def down
  end
end
