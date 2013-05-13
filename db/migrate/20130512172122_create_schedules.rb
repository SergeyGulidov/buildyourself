class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.string :group
      t.string :mon
      t.string :tue
      t.string :wed
      t.string :thu
      t.string :fri
      t.string :sat
      t.string :sun

      t.timestamps
    end
  end
end
