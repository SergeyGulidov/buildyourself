class Place < ActiveRecord::Base

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

  attr_accessible :approved, :email, :vip, :sponsor, :with_review,
  	 :name, :phone, :street, :website,
     :type_ids, :photos_attributes, :photo, :category_ids, :interval_ids,
     :message_ru, :message_lv, :location_ids, :latitude, :longitude, :review_lv, :review_ru, :user_id

  translates :message, :review

  accepts_nested_attributes_for :photos

   validates :email,
    :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create },
    :presence => true, :uniqueness => true

    #TODO: validates :city
    #TODO: validates  :country, :name, :presence => true, :length => { :in => 4..249 }
   validates :name, :uniqueness => true, :presence => true
   validates :name, :presence => true

   scope :approved, where(approved: 1)
   scope :recent, approved.order("created_at desc").limit(10)
   scope :recent5, approved.order("created_at desc").limit(5)
   scope :sponsor, approved.where(sponsor: 1)




   def gmaps4rails_address
    addresses = Location.where('locations.id' => location_ids[1])
    addresses.each do |address|
      return "#{street}, #{address.city}, #{address.country}" 
    end
   end

  def self.by_votes
    approved.select('places.*, coalesce(value, 0) as votes').
    joins('left join place_votes on place_id=places.id').
    order('votes desc')
  end

  def votes
    read_attribute(:votes) || place_votes.sum(:value)
  end

  def to_param
    "#{id}-#{name}".parameterize
  end



  searchable do
    text :name, :boost => 10
    text :message_ru
    text :message_lv
  end


  def self.search(params)

    unless params.empty?
      @type_vip = nil

        @places = approved

        unless params[:type].blank?
          @places = @places.joins(:types).where('types.type_slug' => "#{params[:type]}")
          @type_vip = @places.where(vip: 1)
        end

        unless params[:city].blank?
          @places = @places.joins(:locations).where('locations.location_slug' => "#{params[:city]}")
        end

        unless params[:category].blank?
          @places = @places.joins(:categories).where('categories.category_slug' => "#{params[:category]}") 
        end

        unless params[:interval].blank?
          @places = @places.joins(:intervals).where('intervals.interval_slug' => "#{params[:interval]}") 
        end
        
        @places = @places.page(params[:page]).per(5)

        return @places, @type_vip
    end
  end






end
