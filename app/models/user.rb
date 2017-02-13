class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

 has_many :followings, dependent: :destroy
 has_many :followers, :through => :following
 has_many :attendings
 has_many :events, :through => :attendings

end
