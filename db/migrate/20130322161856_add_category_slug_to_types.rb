class AddCategorySlugToTypes < ActiveRecord::Migration
  def change
    add_column :types, :category, :string
    add_column :types, :slug, :string
  end
end
