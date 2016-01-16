class Band < ActiveRecord::Base
  has_many :band_roles, :dependent => :destroy
  has_many :members, :through => :band_roles, :source => :user
  validates :title, :presence => true
  validates :description, :presence => true
  accepts_nested_attributes_for :band_roles
end
