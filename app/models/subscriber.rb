class Subscriber < ActiveRecord::Base
  attr_accessible :email, :user_id, :created_at

  belongs_to :user


  scope :active, where(confirmed: 1).order("created_at asc").includes(:user).limit(100)
  scope :not_confirmed, where(confirmed:  0).order("created_at asc").includes(:user).limit(100)


	validates :email,
		:format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create },
		:presence => true

	before_save{|subscriber| subscriber.email = subscriber.email.downcase}

  before_create :generate_token

  protected

  def generate_token
    self.confirm_token = loop do
      random_token = SecureRandom.urlsafe_base64
      break random_token unless Subscriber.where(confirm_token: random_token).exists?
    end
  end

end
