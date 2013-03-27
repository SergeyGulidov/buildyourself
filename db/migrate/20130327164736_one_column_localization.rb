class OneColumnLocalization < ActiveRecord::Migration
  def up
  	rename_column :places, :city, :city_ru
  	add_column  :places, :city_lv, :string

  	rename_column :places, :country, :country_lv
  	add_column    :places, :country_ru, :string

  	rename_column :places, :message, :message_ru
  	add_column    :places, :message_lv, :text

  	rename_column :types, :title, :type_name_ru
  	add_column    :types, :type_name_lv, :string

  	rename_column :categories, :category_name, :category_name_ru
  	add_column :categories, :category_name_lv, :string

  	rename_column :intervals, :interval_name, :interval_name_ru
  	add_column :intervals, :interval_name_lv, :string

  end

  def down
  end
end
