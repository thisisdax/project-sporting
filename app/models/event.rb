class Event < ApplicationRecord
  has_many :attendings, dependent: :destroy
  has_many :users, :through => :attendings
  has_many :comments, dependent: :destroy

end
