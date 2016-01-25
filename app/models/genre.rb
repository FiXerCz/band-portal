class Genre < ActiveRecord::Base
  has_and_belongs_to_many :bands
  validates :title, :presence => true
  validates :title, :uniqueness => true

  # RailsAdmin config
  rails_admin do
    list do
      sort_by :title
      include_fields :title, :bands
    end

    edit do
      include_fields :title
    end
  end
end
