class Schedule < ActiveRecord::Base
  attr_accessible :fri, :group, :mon, :sat, :sun, :thu, :tue, :wed, :place_id
  belongs_to :place


  validates :mon, :sat, :sun, :thu, :tue, :wed, :fri, :length => { :maximum => 20 }
  validates :group, :length => { :maximum => 150 }

end
