class Album < ActiveRecord::Base
  validates :title, :presence => true
  validates :released, :presence => true

  belongs_to :band

  has_and_belongs_to_many :songs, :class_name => 'Song', :join_table => 'albums_songs',
                          :foreign_key => :album_id, :association_foreign_key => :song_id

  accepts_nested_attributes_for :songs, reject_if: :all_blank, allow_destroy: true
end
