class ChangePlaceVotesColumn < ActiveRecord::Migration
  def up
  	  connection.execute(%q{
	    alter table place_votes
	    alter column place_id
	    type integer using cast(place_id as integer)
	  })
  end

  def down
  end
end
