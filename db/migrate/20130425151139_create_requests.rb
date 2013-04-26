class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.integer :phone
      t.string :address
      t.string :when

      t.timestamps
    end
  end
end
