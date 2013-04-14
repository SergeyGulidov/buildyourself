class AddColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :about_ru, :text
    add_column :users, :about_lv, :text
    add_column :users, :web_site, :string
    add_column :users, :phone, :string
    add_column :users, :name, :string
  end
end
