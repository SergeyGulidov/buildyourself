class RemoveGroupRuFromSchedules < ActiveRecord::Migration
  def up
    remove_column :schedules, :group_ru
    remove_column :schedules, :group_lv
    add_column :schedules, :group, :string, default: "1"
  end

  def down
    remove_column :schedules, :group
    add_column :schedules, :group_lv, :string
    add_column :schedules, :group_ru, :string
  end
end
