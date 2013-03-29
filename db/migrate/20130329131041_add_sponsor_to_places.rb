class AddSponsorToPlaces < ActiveRecord::Migration
  def change
    add_column :places, :sponsor, :integer, default:0
  end
end
