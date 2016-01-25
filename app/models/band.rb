class Band < ActiveRecord::Base
  self.per_page = 12
  has_many :band_roles, :dependent => :destroy
  has_many :members, :through => :band_roles, :source => :user

  has_many :performers, :dependent => :destroy
  has_many :concerts, through: :performers

  has_many :comments, :dependent => :destroy

  has_and_belongs_to_many :fans, :class_name=>'User', :join_table => 'bands_users',
                          :foreign_key => :band_id, :association_foreign_key => :user_id

  has_and_belongs_to_many :genres

  accepts_nested_attributes_for :band_roles
  has_attached_file :header, styles: {large: "1200x450", thumb: "800x300>" },
                    default_url: "/assets/:style/noimage.png"
  validates_attachment_content_type :header, content_type: /\Aimage\/.*\Z/
  validate :image_dimensions
  validates :title, :presence => true
  validates :title, :uniqueness => true
  validates :description, :presence => true
  validate :has_at_lest_one_member
  validate :has_from_one_to_five_genres

  def band_genres
    genres.collect { |x| x.title }.join ' / '
  end

  private

  def has_at_lest_one_member
    errors.add(:role, 'Must have at least 1 member') if self.band_roles.blank?
  end

  def has_from_one_to_five_genres
    errors.add(:genres, 'Must have at least 1 genre') if self.genres.blank?
    errors.add(:genres, 'Cannot have more than 5 genres') if self.genres.size > 5
  end

  def image_dimensions
    temp_file = header.queued_for_write[:original]
    unless temp_file.nil?
      required_width  = (1200..2000)
      required_height = (400..450)
      dimensions = Paperclip::Geometry.from_file(temp_file.path)

      errors.add(:image, "Header width must be within #{required_width}px") unless required_width.member? dimensions.width
      errors.add(:image, "Header height must be within #{required_height}px") unless required_height.member? dimensions.height
    end
  end

end
