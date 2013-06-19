class AddSimplePlaceToPlaces < ActiveRecord::Migration
  def change
    add_column :places, :simple_place, :integer, default: 1
    add_column :places, :phone, :integer
    add_column :places, :email, :string
    add_column :places, :website, :string
  end
end
