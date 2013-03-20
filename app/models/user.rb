class User < ActiveRecord::Base

	has_one :role
  has_many :places
	
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body


 

  def role?(role)
    if defined? self.role.name
      self.role.name == role.to_s 
    else
      false
    end

  end


end
