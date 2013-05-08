class ChangePostsModel < ActiveRecord::Migration
  def up
  	add_column 		:posts, :approved, :integer, default: 0 
  	remove_column   :feeds, :updated_at
  	add_column 		:posts, :user_id, :integer, default: 1
  	remove_column   :posts, :author
  	add_column      :posts, :file, :string
  end

  def down
  end
end
