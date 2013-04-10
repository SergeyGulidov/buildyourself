class AddValueToPlaceVote < ActiveRecord::Migration
	def up
		remove_column :place_votes, :place_id
		add_column :place_votes, :place_id, :integer
	end
end
