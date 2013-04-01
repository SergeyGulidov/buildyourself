class User < ActiveRecord::Base
  has_many :places
  has_many :place_votes

	
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :role, :sign_in_count, :created_at
  # attr_accessible :title, :body


  def total_votes
    PlaceVote.joins(:place).where(places: {user_id: self.id}).sum('value')
  end

  def can_vote_for?(place)
    place_votes.build(value: 1, place: place).valid?
  end


end
