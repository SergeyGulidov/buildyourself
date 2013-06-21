class CreateByways < ActiveRecord::Migration
  def change
    create_table :byways do |t|
      t.string :street
      t.integer :place_id
      t.integer :city_id
      t.integer :country_id
      t.float :latitude
      t.float :longitude
      t.boolean :gmaps
    end
  end
end
