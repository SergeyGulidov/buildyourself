class AddCityToPlaceTranslations < ActiveRecord::Migration
  def change
    add_column :place_translations, :city, :string
    remove_column :place_translations, :type
    remove_column :place_translations, :name
  end
end
