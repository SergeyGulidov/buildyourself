class PlaceVote < ActiveRecord::Base
  attr_accessible :place_id, :user_id, :value, :place

  belongs_to :place, dependent: :destroy
  belongs_to :user


  validates_uniqueness_of :place_id, scope: :user_id
  validates_inclusion_of :value, in: [1, -1]
  validate :ensure_not_author

  def ensure_not_author
    errors.add :user_id, "is the author of the haiku" if place.user_id == user_id
  end
end
