class AddUserIdToSchedules < ActiveRecord::Migration
  def change
    add_column :schedules, :user_id, :integer
    add_column :schedules, :place_id, :integer
  end
end
