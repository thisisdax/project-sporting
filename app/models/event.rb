class Event < ApplicationRecord
  validates :name, :date, :time, :minpax, :maxpax, presence: true

  has_many :attendings, dependent: :destroy
  has_many :users, :through => :attendings
  has_many :comments, dependent: :destroy

  has_many :event_tags
  has_many :tags, :through => :event_tags
end
