class Album < ActiveRecord::Base
  validates :title, :presence => true
  validates :released, :presence => true

  belongs_to :band

  has_attached_file :image, styles: { thumb: "800x300#" }, :storage => :database,
                    default_url: "/assets/:style/noimage.png", :url => '/:class/:id/:attachment/:style'

  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  validate :image_dimensions

  has_and_belongs_to_many :songs, :class_name => 'Song', :join_table => 'albums_songs',
                          :foreign_key => :album_id, :association_foreign_key => :song_id

  accepts_nested_attributes_for :songs, reject_if: :all_blank, allow_destroy: true

  def image_dimensions
    temp_file = image.queued_for_write[:original]
    unless temp_file.nil?
      required_width  = (400..2000)
      required_height = (400..2000)
      dimensions = Paperclip::Geometry.from_file(temp_file.path)

      errors.add(:image, "Image must be square") unless (dimensions.width / dimensions.height) == 1
      errors.add(:image, "Image width must be within #{required_width}px") unless required_width.member? dimensions.width
      errors.add(:image, "Image height must be within #{required_height}px") unless required_height.member? dimensions.height
    end
  end


end
