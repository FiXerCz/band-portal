class Concert < ActiveRecord::Base
  validates :title, :location, :capacity, :from_date, :to_date, :price, :presence => true
  validates :capacity, numericality: { only_integer: true }
  validates :price, numericality: { greather_than: 0 }
end
