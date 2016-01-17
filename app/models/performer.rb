class Performer < ActiveRecord::Base
  after_create :set_confirmation

  def set_confirmation
    self.update(confirmed: false)
  end
end
