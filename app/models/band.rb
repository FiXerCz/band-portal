class Band < ActiveRecord::Base
  self.per_page = 12
  has_many :band_roles, :dependent => :destroy
  has_many :members, :through => :band_roles, :source => :user

  has_many :performers, :dependent => :destroy
  has_many :concerts, through: :performers

  has_many :comments
  has_many :users, through: :comments

  has_and_belongs_to_many :fans, :class_name=>'User', :join_table => 'bands_users',
                          :foreign_key => :band_id, :association_foreign_key => :user_id

  has_and_belongs_to_many :genres

  accepts_nested_attributes_for :band_roles
  validates :title, :presence => true
  validates :title, :uniqueness => true
  validates :description, :presence => true
  validate :has_from_one_to_five_genres

  def has_from_one_to_five_genres
    errors.add(:genres, 'Must have at least 1 genre') if self.genres.blank?
    errors.add(:genres, 'Cannot have more than 5 genres') if self.genres.size > 5
  end

  def band_genres
    genres.collect { |x| x.title }.join ' / '
  end
end
