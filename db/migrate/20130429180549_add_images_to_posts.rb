class AddImagesToPosts < ActiveRecord::Migration
  def change
  	add_column :posts, :hits,   :integer, default: 0
  	add_index :posts, :id
  end
end
