class Schedule < ActiveRecord::Base
  attr_accessible :fri, :group_lv, :group_ru, :mon, :sat, :sun, :thu, :tue, :wed, :place_id
  belongs_to :place

  translates :group

  validates :mon, :sat, :sun, :thu, :tue, :wed, :fri, :length => { :maximum => 20 }
  validates :group_lv, :group_ru, :length => { :maximum => 30 }

end
