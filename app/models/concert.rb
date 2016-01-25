class Concert < ActiveRecord::Base
  self.per_page = 10
  validates :title, :location, :from_date, :to_date, :price, :presence => true
  validates :capacity, numericality: { only_integer: true }, allow_blank: true
  validates :price, numericality: { greather_than: 0 }
  validates_datetime :from_date,
                     on_or_after: lambda { DateTime.current }
  validates_datetime :to_date, :after => :from_date,
                     :after_message => "must be after 'From date'"

  has_many :performers, :dependent => :destroy
  has_many :bands, through: :performers

  # RailsAdmin config
  rails_admin do
    list do
      include_fields :title, :location, :bands, :from_date, :to_date
    end

    show do
      include_fields :title, :location, :performers, :from_date, :to_date, :price, :capacity
    end

    edit do
      exclude_fields :performers
    end
  end
end
