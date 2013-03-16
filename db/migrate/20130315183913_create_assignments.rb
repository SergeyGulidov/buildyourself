class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
      t.integer :place_id
      t.integer :type_id
    end
  end
end
