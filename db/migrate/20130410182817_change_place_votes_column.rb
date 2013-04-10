class ChangePlaceVotesColumn < ActiveRecord::Migration
  def up
  	change_column :place_votes, :place_id, :integer, default: 0
  end

  def down
  end
end
