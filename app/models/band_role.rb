class BandRole < ActiveRecord::Base
  belongs_to :band
  belongs_to :user
  validates :role, :presence => true
end
