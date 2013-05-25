class AddRuToPlaces < ActiveRecord::Migration
  def change
    add_column :places, :ru, :integer, default: 0
    add_column :places, :lv, :integer, default: 0
    add_column :posts, :ru,  :integer, default: 0
    add_column :posts, :lv,  :integer, default: 0
  end
end
