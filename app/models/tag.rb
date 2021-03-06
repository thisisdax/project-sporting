class Tag < ApplicationRecord
  belongs_to :tag_category

  has_many :event_tags
  has_many :events, :through => :event_tags

  has_many :interests
  has_many :users, :through => :interests
end
