class ChangeRequestTable < ActiveRecord::Migration
  def up
  	change_column :requests, :phone, :string
  end

  def down
  end
end
