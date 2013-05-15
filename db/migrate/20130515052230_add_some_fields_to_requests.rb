class AddSomeFieldsToRequests < ActiveRecord::Migration
  def change
    add_column :requests, :message, :text
    add_column :photos, :request_id, :integer
    add_column :requests, :email, :string
 
  end
end
