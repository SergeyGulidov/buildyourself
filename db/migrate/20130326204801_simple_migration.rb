class SimpleMigration < ActiveRecord::Migration
  def up
  	remove_column :category_translations, :created_at
  	remove_column :category_translations, :updated_at
  end

  def down
  end
end
