class Concert < ActiveRecord::Base
  validates :title, :location, :capacity, :from_date, :to_date, :price, :presence => true
end
