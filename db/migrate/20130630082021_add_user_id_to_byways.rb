class AddUserIdToByways < ActiveRecord::Migration
  def change
    add_column :byways, :user_id, :integer, default: 1
  end
end
