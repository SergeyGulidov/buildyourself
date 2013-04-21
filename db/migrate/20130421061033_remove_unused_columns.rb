class RemoveUnusedColumns < ActiveRecord::Migration
  def up
  	remove_columns :places, :email
  	remove_columns :places, :phone
  	remove_columns :places, :website
  	remove_columns :places, :sponsor
  	remove_columns :places, :comment
  	remove_columns :places, :training_time
  end

  def down
  end
end
