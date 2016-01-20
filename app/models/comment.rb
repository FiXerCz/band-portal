class Comment < ActiveRecord::Base
  self.per_page = 10
  validates :text, :presence => true

  belongs_to :band
  belongs_to :user
end
