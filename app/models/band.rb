class Band < ActiveRecord::Base
  has_many :band_roles, :dependent => :destroy
  has_many :members, :through => :band_roles, :source => :user

  has_many :performers
  has_many :concerts, through: :performers

  accepts_nested_attributes_for :band_roles
  validates :title, :presence => true
  validates :title, :uniqueness => true
  validates :description, :presence => true
end
