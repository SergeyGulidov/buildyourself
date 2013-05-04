class CreateFeeds < ActiveRecord::Migration
  def change
    create_table :feeds do |t|
      t.string :message
      t.integer :place_id
      t.timestamps
    end
    add_index :feeds, :place_id
  end
end
