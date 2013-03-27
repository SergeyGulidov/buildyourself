class Categorization < ActiveRecord::Base
   attr_accessible :category_id, :type_id, :place_id, :interval_id
   belongs_to :type
   belongs_to :category
   belongs_to :place
   belongs_to :interval

end
