class Place < ActiveRecord::Base

  include Tire::Model::Search

  belongs_to :city
  belongs_to :country
  belongs_to :user
  belongs_to :category
  belongs_to :type

  has_many :byways, :dependent => :destroy
  has_many :feeds, :order => 'created_at DESC', :dependent => :destroy
  has_many :photos, :dependent => :destroy
  has_many :place_votes, :dependent => :destroy
  has_many :schedules, :dependent => :destroy


  before_validation{|place| place.slug = place.slug.downcase unless place.slug.blank? }

  extend FriendlyId
  friendly_id :slug


  after_save do
    update_index
  end

  after_update do
    update_index
  end

  after_destroy do
    update_index
  end

  attr_accessible :vip, :sponsor, :age_max, :age_min, :simple_place, :email, :phone, :website,
  	 :name, :phone, :website, :country_id, :city_id,
     :type_id, :photos_attributes, :photo, :category_id, :month_price,
     :message_ru, :message_lv, :user_id, :slug, :ru, :lv

  translates :message

  accepts_nested_attributes_for :photos, :allow_destroy => true 


   validates :country, presence: true
   validates :city,    presence: true
   validates :age_min, :length => { :minimum => 0, :maximum => 3 }
   validates :age_max, :length => { :minimum => 0, :maximum => 3 }
   validates :slug, :format => { :with => /^[a-zA-Z0-9]+$/, :message => "Only letters and numbers allowed" },
                    :uniqueness => true,
                    :allow_blank => true


  mapping do
        indexes :id,         :index    => :not_analyzed
        indexes :name,       :analyzer => 'snowball', :boost => 100
        indexes :message_lv, :analyzer => 'snowball'
        indexes :message_ru, :analyzer => 'snowball'
        indexes :street,     :analyzer => 'snowball'
  end


  def to_indexed_json
    to_json(:include => [:type, :category, :city])
  end

   scope :other_user_places, select("id, name, street, slug").order("updated_at desc").limit(50)

   scope :approved_ru, where(ru: 1).includes( :type, :category, :city, :byways, :user ).limit(50)
   scope :approved_lv, where(lv: 1).includes( :type, :category, :city, :byways, :user ).limit(50)
   scope :recent, order("updated_at desc").includes(:type).limit(10)
   

  def to_param
    if slug.blank?
      "#{id}-#{name}".parameterize
    else
      "#{slug}"
    end
  end


  def self.by_votes
    approved.select('places.*, coalesce(value, 0) as votes').
    joins('left join place_votes on place_id=places.id').
    order('votes desc')
  end

  def votes
     vote ||= place_votes.sum(:value)
    return vote
  end





  def self.search(params)
    tire.search(load: true, page: params[:page], per_page: 10 ) do
      query { string params[:search], default_operator: "AND"}
    end
  end


  def self.get_places
      if I18n.locale == :ru
        Place.approved_ru
      else
        Place.approved_lv
      end
  end

  def self.first_step_search(params)

      type_vip = nil
      places = get_places
      watcher = 0 # to know what page this is 


      unless params[:category].blank?
        places = places.where( "categories.category_slug = ?", params[:category] ) 
        watcher = 1
      end


      f_type = params[:f].fetch(:type) unless params[:f].blank?
      unless f_type.blank?
        type_vip = places.where("types.type_slug = ? AND vip = ?", params[:f][:type], 1 )
        places = places.where( "types.type_slug = ? AND vip = ?", params[:f][:type], 0 )
        watcher = 1
      end
      unless params[:type].blank?
        type_vip = places.where("types.type_slug = ? AND vip = ?", params[:type], 1 )
        places = places.where( "types.type_slug = ? AND vip = ?", params[:type], 0 )
        watcher = 1
      end

      unless params[:city].blank?
        places = places.where( "cities.city_slug = ?", params[:city] )
        watcher = 1
      end

      unless params[:age].blank?
        places = places.where( "age_min <= ? AND age_max >= ?", params[:age].to_i,  params[:age].to_i ) 
        watcher = 1
      end

      return places, type_vip, watcher
  end

  def hit
    self.hits += 1
    self.save
  end
end
