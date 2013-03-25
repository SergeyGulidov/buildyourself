class CreateCities < ActiveRecord::Migration
  def change
    create_table :cities do |t|
      t.integer :place_id
      t.string :city_name
    end
    City.create_translation_table! :city_name => :string

    remove_column :places, :city
    add_column    :places, :city_id
  end
end
