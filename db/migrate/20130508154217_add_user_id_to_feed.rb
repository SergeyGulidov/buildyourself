class AddUserIdToFeed < ActiveRecord::Migration
  def change
    add_column :feeds, :user_id, :integer, default: 1
  end
end
