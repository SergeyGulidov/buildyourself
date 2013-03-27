class DeleteGlobalization < ActiveRecord::Migration
  def up

  	drop_table :type_translations
  	drop_table :interval_translations
  	drop_table :place_translations
  	drop_table :category_translations

  	add_column :places, :review_ru, :text
  	add_column :places, :review_lv, :text
  	add_column :places, :with_review, :integer, default: 0
  end

  def down
  end
end
