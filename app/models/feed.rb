class Feed < ActiveRecord::Base
   attr_accessible :message, :place_id

   validates :message, :length => { :minimum => 3, :maximum => 255 }
   validates :place_id, presence: true
end
