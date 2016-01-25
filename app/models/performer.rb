class Performer < ActiveRecord::Base
  belongs_to :band
  belongs_to :concert
  after_create :set_confirmation

  def set_confirmation
    self.update(confirmed: false)
  end

  # RailsAdmin config
  rails_admin do
    visible false
  end

  def title
    "#{band.title} (#{confirmed ? 'confirmed' : 'unconfirmed'})"
  end
end
