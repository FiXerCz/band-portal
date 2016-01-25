class Song < ActiveRecord::Base
  validates :title, :presence => true
  validates :lyrics, :presence => true
  validates :composer, :presence => true

  belongs_to :band
  has_and_belongs_to_many :album
end
