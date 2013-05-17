class Post < ActiveRecord::Base
  belongs_to :user

  attr_accessible :image, :message_lv, :message_ru, :title_lv, :title_ru, :approved, :file, :image_cache

  include Tire::Model::Search

  mount_uploader :image, ImageUploader


  translates :message, :title
  
  scope :latest, where(approved: 1).order("created_at desc").includes(:user).limit(100)
  scope :recent, where(approved: 1).order("created_at desc").limit(10)
  scope :unapproved, where(approved: 0).order("created_at asc").limit(100)

  before_save{|post| post.title_lv = post.title_lv.titleize unless post.title_lv.blank?}
  before_save{|post| post.title_ru = post.title_ru.titleize unless post.title_ru.blank?}


  mapping do
        indexes :id,         :index    => :not_analyzed
        indexes :title_lv,   :analyzer => 'snowball', :boost => 100
        indexes :title_ru,   :analyzer => 'snowball', :boost => 90
        indexes :message_lv, :analyzer => 'snowball'
        indexes :message_ru, :analyzer => 'snowball'
  end


  after_save do
    update_index if approved == 1
  end

  after_update do
    update_index if approved == 1
  end
  
  after_destroy do
    update_index
  end


  def to_param
    "#{id}-#{title_lv}".parameterize
  end

  def self.search(params)
    tire.search(load: true, page: params[:page], per_page: 10 ) do
      query { string params[:search], default_operator: "AND"}
    end
  end

  def self.current_posts(id)
    where(user_id: id).all
  end

end
