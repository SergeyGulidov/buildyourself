class AddGroupNameToSchedules < ActiveRecord::Migration
  def change
    add_column :schedules, :group_lv, :string
    add_column :schedules, :group_ru, :string
    remove_column :schedules, :group
  end
end
