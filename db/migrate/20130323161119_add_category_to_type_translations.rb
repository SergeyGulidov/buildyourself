class AddCategoryToTypeTranslations < ActiveRecord::Migration
  def change
    add_column :type_translations, :category, :string
  end
end
