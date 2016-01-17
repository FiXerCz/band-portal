class BandRole < ActiveRecord::Base
  belongs_to :band
  belongs_to :user
  validates :role, :presence => true
  validates :user_id, :presence => true
end
