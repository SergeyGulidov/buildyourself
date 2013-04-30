class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title_ru
      t.string :title_lv
      t.text :message_lv
      t.text :message_ru
      t.string :author
      t.string :image

      t.timestamps
    end
  end
end
