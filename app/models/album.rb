class Album < ActiveRecord::Base
  validates :title, :presence => true
  validates :released, :presence => true

  belongs_to :band
  has_and_belongs_to_many :song
end
