class Schedule < ActiveRecord::Base
  attr_accessible :fri, :group, :mon, :sat, :sun, :thu, :tue, :wed
end
