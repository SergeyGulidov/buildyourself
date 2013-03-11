class CreatePlaces < ActiveRecord::Migration
  def change
    create_table :places do |t|
      t.string :country
      t.string :city
      t.string :street
      t.string :phone
      t.string :website
      t.string :email
      t.string :name
      t.boolean :manytypes
      t.string :type
      t.boolean :approved
      t.text :message
      

      t.timestamps
    end
  end
end
