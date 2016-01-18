class Genre < ActiveRecord::Base
  has_and_belongs_to_many :bands
  validates :title, :presence => true
  validates :title, :uniqueness => true
end
