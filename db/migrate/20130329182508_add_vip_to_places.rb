class AddVipToPlaces < ActiveRecord::Migration
  def change
    add_column :places, :vip, :integer, default: 0
  end
end
