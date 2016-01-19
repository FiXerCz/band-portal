class Performer < ActiveRecord::Base
  belongs_to :band
  belongs_to :concert
  after_create :set_confirmation

  def set_confirmation
    self.update(confirmed: false)
  end
end
