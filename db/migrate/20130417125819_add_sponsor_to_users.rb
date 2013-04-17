class AddSponsorToUsers < ActiveRecord::Migration
  def change
    add_column :users, :sponsor, :integer, default: 0
  end
end
