class Post < ActiveRecord::Base
  attr_accessible :author, :image, :message_lv, :message_ru, :title_lv, :title_ru

  include Tire::Model::Search
  include Tire::Model::Callbacks

  mount_uploader :image, ImageUploader

  validates :title_ru,    presence: true
  validates :title_lv,    presence: true

  translates :message, :title

  scope :recent, order("created_at desc").limit(10)
  scope :latest, order("created_at desc").all


  def to_param
    "#{id}-#{title_lv}".parameterize
  end

  def self.search(params)
    tire.search(load: true, page: params[:page], per_page: 10 ) do
      query { string params[:search], default_operator: "AND"}
    end
  end

end
