class User < ActiveRecord::Base
  self.per_page = 20
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :band_roles
  has_many :bands, through: :band_roles
end
