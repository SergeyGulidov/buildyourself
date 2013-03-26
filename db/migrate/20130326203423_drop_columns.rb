class DropColumns < ActiveRecord::Migration
  def up

  	remove_column :types, :category
  	remove_column :categorizations, :id
  	remove_column :assignments, :id

  	Category.create_translation_table! :category_name => :string
  end

  def down
  end
end
