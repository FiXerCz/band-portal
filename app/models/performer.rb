class Performer < ActiveRecord::Base
  belongs_to :band
  belongs_to :concert
end
