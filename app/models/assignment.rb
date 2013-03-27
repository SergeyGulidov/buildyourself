class Assignment < ActiveRecord::Base
  attr_accessible :place_id, :type_id

  belongs_to :place
  belongs_to :type
end
