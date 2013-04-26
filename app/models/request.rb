class Request < ActiveRecord::Base
  attr_accessible :address, :phone, :when

  validates :address, :presence => true
  validates :phone, :presence => true, :numericality => true, :length => { :maximum => 12, :minimum => 8 }
  validates :when, :presence => true

end
