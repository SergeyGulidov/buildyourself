class RenameImageColumn < ActiveRecord::Migration
  def up
  	rename_column :photos, :image, :photo
  end

  def down
  end
end
