class Place < ActiveRecord::Base

  belongs_to :city
  belongs_to :country
  belongs_to :user


  has_many :categorizations
  has_many :categories, through: :categorizations
  has_many :intervals,  through: :categorizations
  has_many :types,      through: :categorizations

  has_many :photos, :dependent => :destroy
  has_many :place_votes
  

  acts_as_gmappable

  before_save{|place| place.email = place.email.downcase}
  before_save{|place| place.name = place.name.titleize}


  attr_accessible :approved, :email, :vip, :sponsor, :with_review,
  	 :name, :phone, :street, :website, :country_id, :city_id,
     :type_ids, :photos_attributes, :photo, :category_ids, :interval_ids,
     :message_ru, :message_lv, :latitude, :longitude, :review_lv, :review_ru, :user_id

  translates :message, :review

  accepts_nested_attributes_for :photos

   validates :email,
    :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create },
    :presence => true, :uniqueness => true

   validates :name, :uniqueness => true, :presence => true






   scope :approved, where(approved: 1)
   scope :recent, approved.order("created_at desc").limit(10)
   scope :recent5, approved.order("created_at desc").limit(5)
   scope :sponsor, approved.where(sponsor: 1)




   def gmaps4rails_address
      return "#{street}, #{city.city_name}, #{country.country_name}" 
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


  def self.first_step_search(params)

      type_vip = nil
      places = Place.approved


      unless params[:type].blank?
        places = places.joins(:types).where('types.type_slug' => "#{params[:type]}")
        type_vip = places.where(vip: 1)
      end

      unless params[:city].blank?
        places = places.where(city_id = params[:city].to_i)
      end

      unless params[:category].blank?
        places = places.joins(:categories).where('categories.category_slug' => "#{params[:category]}") 
      end

      unless params[:interval].blank?
        places = places.joins(:intervals).where('intervals.interval_slug' => "#{params[:interval]}") 
      end
      
      places = places.page(params[:page]).per(5)

      return places, type_vip

  end
end
