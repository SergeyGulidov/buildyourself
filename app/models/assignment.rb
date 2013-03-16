class Assignment < ActiveRecord::Base
  belongs_to :place
  belongs_to :type
end
