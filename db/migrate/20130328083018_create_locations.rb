class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :city_lv
      t.string :city_ru
      t.string :country_lv
      t.string :country_ru
      t.string :slug
    end
  end
end
