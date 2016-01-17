class Concert < ActiveRecord::Base
  validates :title, :location, :from_date, :to_date, :price, :presence => true
  validates :capacity, numericality: { only_integer: true }
  validates :price, numericality: { greather_than: 0 }
  validate :end_after_start

  has_many :performers
  has_many :bands, through: :performers

  def end_after_start
    if to_date < from_date
      errors.add(:to_date, "must be after the start date")
    end
  end
end
