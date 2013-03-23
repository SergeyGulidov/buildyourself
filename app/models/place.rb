class Place < ActiveRecord::Base
  has_many :assignments
  has_many :types, through: :assignments
  has_many :photos, :dependent => :destroy

  belongs_to :user

  has_many :place_votes

  acts_as_gmappable


  before_save{|place| place.email = place.email.downcase}

  attr_accessible :approved, :city, :country, :email, :manytypes,
  	 :message, :name, :phone, :street, :website, :translations_attributes,
     :type_ids, :photos_attributes, :photo


  translates :message

  accepts_nested_attributes_for :translations, :photos

   validates :email,
    :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create },
    :presence => true, :uniqueness => true


   validates :city, :country, :name, :presence => true, :length => { :in => 4..249 }
   validates :name, :uniqueness => true


   scope :recent, order("created_at desc").limit(10)
   scope :recent5, where(approved: 1).order("created_at desc").limit(5)

   def gmaps4rails_address
    "#{street}, #{city}, #{country}" 
   end

  def self.by_votes
    select('places.*, coalesce(value, 0) as votes').
    joins('left join place_votes on place_id=places.id').
    order('votes desc')
  end

  def votes
    read_attribute(:votes) || place_votes.sum(:value)
  end

  def to_param
    "#{id}-#{name}".parameterize
  end




end
