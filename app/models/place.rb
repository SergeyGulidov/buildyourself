class Place < ActiveRecord::Base
  # has_many :assignments
 

  

  has_many :categorizations

  has_many :categories, through: :categorizations
  has_many :intervals,  through: :categorizations
  has_many :types,      through: :categorizations
  has_many :locations,  through: :categorizations
  has_many :photos, :dependent => :destroy
  has_many :place_votes

  belongs_to :user
  

  acts_as_gmappable


  before_save{|place| place.email = place.email.downcase}

  attr_accessible :approved, :email, :manytypes,
  	 :message, :name, :phone, :street, :website,
     :type_ids, :photos_attributes, :photo, :category_ids, :interval_ids, :message_ru, :message_lv, :location_ids


  translates :message

  accepts_nested_attributes_for :photos

   validates :email,
    :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create },
    :presence => true, :uniqueness => true

    #TODO: validates :city
    #TODO: validates  :country, :name, :presence => true, :length => { :in => 4..249 }
   validates :name, :uniqueness => true



   scope :approved, where(approved: 1)
   scope :recent, approved.order("created_at desc").limit(10)
   scope :recent5, approved.order("created_at desc").limit(5)




   def gmaps4rails_address
    "#{street}, #{city}, #{country}" 
   end

  def self.by_votes
    where(approved: 1).select('places.*, coalesce(value, 0) as votes').
    joins('left join place_votes on place_id=places.id').
    order('votes desc')
  end

  def votes
    read_attribute(:votes) || place_votes.sum(:value)
  end

  def to_param
    "#{id}-#{name}".parameterize
  end

  def self.search(search)

    @places = approved

    @places = @places.joins(:locations).where('locations.location_slug' => "#{search[:city]}") unless search[:city].blank?
    @places = @places.joins(:types).where('types.type_slug' => "#{search[:type]}") unless search[:type].blank?
    @places = @places.joins(:categories).where('categories.category_slug' => "#{search[:category]}") unless search[:category].blank?
    @places = @places.joins(:intervals).where('intervals.interval_slug' => "#{search[:interval]}") unless search[:interval].blank?

    return @places
  end


end
