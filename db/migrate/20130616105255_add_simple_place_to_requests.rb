class AddSimplePlaceToRequests < ActiveRecord::Migration
  def change
    add_column :requests, :simple_place, :integer
    add_column :requests, :website, :string
    add_column :requests, :age_max, :integer
    add_column :requests, :age_min, :integer
  end
end
