class AddImagesToRequest < ActiveRecord::Migration
  def change
    add_column :requests, :source_1, :string
    add_column :requests, :source_2, :string
    add_column :requests, :source_3, :string
    add_column :requests, :source_4, :string
  end
end
