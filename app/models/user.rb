class User < ActiveRecord::Base
  has_many :places
  has_many :place_votes

	before_create :set_user_role


  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # , :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :lockable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :sign_in_count, :created_at, :role
  # attr_accessible :title, :body


  def total_votes
    PlaceVote.joins(:place).where(places: {user_id: self.id}).sum('value')
  end

  def can_vote_for?(place)
    place_votes.build(value: 1, place: place).valid?
  end

  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
    end
  end

  def self.new_with_session(params, session)
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"], without_protection: true ) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end    
  end

  def password_required?
    super && provider.blank?
  end

  def update_with_password(params, *options)
    if encrypted_password.blank?
      update_attributes(params, *options)
    else
      super
    end
    
  end


  def set_user_role
    self.role = 2   
  end

end
