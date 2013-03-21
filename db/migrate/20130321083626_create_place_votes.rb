class CreatePlaceVotes < ActiveRecord::Migration
  def change
    create_table :place_votes do |t|
      t.integer :place_id
      t.integer :user_id
      t.integer :value


    end

	add_index "place_votes", ["place_id"], :name => "index_place_votes_on_place_id"
	add_index "place_votes", ["user_id"], :name => "index_place_votes_on_user_id"

  end
end
