class CreateSubscribers < ActiveRecord::Migration
  def change
    create_table :subscribers do |t|
      t.string  :email
      t.integer :user_id
      t.integer :confirmed, default: 0
      t.string :confirm_token
      t.timestamps
    end

    add_index :subscribers, :user_id
  end
end
