class RemoveUnusedColumnsBeforeStart < ActiveRecord::Migration
  def up
  	remove_column :places, :review_ru
  	remove_column :places, :review_lv
  	remove_column :places, :with_review
  	remove_column :requests, :updated_at
  	remove_column :categories, :count_all
  	remove_column :photos, :name
  	remove_column :types, :count_all
  	remove_column :cities, :count_all
  end

  def down
  end
end
