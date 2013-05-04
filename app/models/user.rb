class User < ActiveRecord::Base
  has_many :places
  has_many :place_votes

  translates :about
  
  mount_uploader :avatar, AvatarUploader

  # :token_authenticatable, :confirmable, :timeoutable

  devise :database_authenticatable, :registerable, :lockable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable


  attr_accessible :email, :password, :password_confirmation, 
  :remember_me, :sign_in_count, :created_at, :avatar, :avatar_cache, :comments,
  :about_ru, :about_lv, :web_site, :phone, :name, :sponsor

  before_save{|user| user.email = user.email.downcase}
  
  validates :email,
    :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create },
    :presence => true,
    :uniqueness => true

  scope :sponsor, User.where(sponsor: 1).first

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

  def to_param
    "#{id}-#{name}".parameterize
  end


end
