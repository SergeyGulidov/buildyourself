class RenameSlug < ActiveRecord::Migration
  def up

  	add_column :categorizations, :location_id, :integer
  end

  def down
  end
end
