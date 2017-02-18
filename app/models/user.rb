class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :omniauthable, :omniauth_providers => [:facebook]
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable
        #  , :validatable, :confirmable

  has_many :followings, dependent: :destroy
  has_many :followers, :through => :following
  has_many :attendings
  has_many :events, :through => :attendings
  has_many :comments, dependent: :destroy

  has_many :interests
  has_many :tags, :through => :interests


  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      # user.name = auth.info.name   # assuming the user model has a name. model no name field currently
      user.image = auth.info.image # assuming the user model has an image
      user.name = auth.info.name
      user.first_name = auth.extra.raw_info.first_name
      user.last_name = auth.extra.raw_info.last_name
      user.min_age = auth.extra.raw_info.age_range.min.last
      user.gender = auth.extra.raw_info.gender
      user.birthday = Date.strptime(auth.extra.raw_info.birthday,'%m/%d/%Y')
      # If you are using confirmable and the provider(s) you use validate emails,
      # uncomment the line below to skip the confirmation emails.
      # user.skip_confirmation!
    end
  end



end
