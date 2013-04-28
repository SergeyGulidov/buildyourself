class Place < ActiveRecord::Base

  belongs_to :city
  belongs_to :country
  belongs_to :user


  has_many :categorizations
  has_many :categories, through: :categorizations

  has_many :types,      through: :categorizations

  has_many :photos, :dependent => :destroy
  has_many :place_votes, :dependent => :destroy
  

  acts_as_gmappable

  
  before_save{|place| place.name = place.name.titleize}




  after_save do
    update_index if translated == 1 and approved == 1
  end

  after_update do
    update_index if translated == 1 and approved == 1
  end

  attr_accessible :approved, :email, :vip, :sponsor, :age_max, :age_min,
  	 :name, :phone, :street, :website, :country_id, :city_id,
     :type_ids, :photos_attributes, :photo, :category_ids, :month_price,
     :message_ru, :message_lv, :latitude, :longitude, :user_id, :translated

  translates :message

  accepts_nested_attributes_for :photos


   validates :country, presence: true
   validates :city,    presence: true
   validates :name,    presence: true
   validates :street, presence: true
   validates :age_min, :length => { :minimum => 1, :maximum => 3 }
   validates :age_max, :length => { :minimum => 1, :maximum => 3 }

  include Tire::Model::Search

  mapping do
        indexes :id,         :index    => :not_analyzed
        indexes :name,       :analyzer => 'snowball', :boost => 100
        indexes :message_lv, :analyzer => 'snowball'
        indexes :message_ru, :analyzer => 'snowball'
  end


  def to_indexed_json
    to_json(:include => [:types, :categories, :city])
  end


   scope :approved, where(approved: 1, translated: 1).order("updated_at desc").includes(:photos, :types, :categories, :city)
   scope :recent,  where(approved: 1).order("updated_at desc").includes(:types).limit(10)
   




   def gmaps4rails_address
      return "#{street}, #{city.city_name}, #{country.country_name.to_s}" 
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

  def to_param
    "#{id}-#{name}".parameterize
  end



  def self.search(params)
    tire.search(load: true, page: params[:page], per_page: 10 ) do
      query { string params[:search], default_operator: "AND"}
    end
  end


  def self.first_step_search(params)

      type_vip = nil
      places = Place.approved

      unless params[:category].blank?
        places = places.where( "categories.category_slug = ?", params[:category] ) 
      end


      f_type = params[:f].fetch(:type) unless params[:f].blank?
      unless f_type.blank?
        type_vip = places.where("types.type_slug = ? AND vip = ?", params[:f][:type], 1 )
        places = places.where( "types.type_slug = ? AND vip = ?", params[:f][:type], 0 )
        
      end
      unless params[:type].blank?
        type_vip = places.where("types.type_slug = ? AND vip = ?", params[:type], 1 )
        places = places.where( "types.type_slug = ? AND vip = ?", params[:type], 0 )
      end

      unless params[:city].blank?
        places = places.where( "cities.city_slug = ?", params[:city] )
      end
      unless params[:age].blank?
        places = places.where( "age_min <= ? AND age_max >= ?", params[:age].to_i,  params[:age].to_i ) 
      end

      return places, type_vip
  end

  def count_all
    self.category_ids.each do |category|
      cat = Category.find(category.to_i)
      cat.add_count
    end

    self.type_ids.each do |type|
      type = Type.find(type.to_i)
      type.add_count
    end

    City.find(city_id.to_i).add_count



         self.category_ids.each do |category|
       cat = Category.find(category.to_i)
       cat.minus_count
     end
     self.type_ids.each do |type|
       type = Type.find(type.to_i)
       type.minus_count
     end
     City.find(city_id.to_i).minus_count
  end


end
