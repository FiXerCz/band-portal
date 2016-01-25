class BandRole < ActiveRecord::Base
  belongs_to :band
  belongs_to :user
  validates :role, :presence => true
  validates :user_id, :presence => true

  # RailsAdmin config
  def title
    "#{user.pretty_name} (#{role})" if user
  end

  rails_admin do
    visible false

    edit do
      exclude_fields :band
    end
  end
end
