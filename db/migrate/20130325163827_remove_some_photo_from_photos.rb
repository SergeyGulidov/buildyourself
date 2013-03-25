class RemoveSomePhotoFromPhotos < ActiveRecord::Migration
  def up
  	remove_column :photos, :created_at
  	remove_column :photos, :updated_at
  end

  def down
  end
end
