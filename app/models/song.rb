class Song < ActiveRecord::Base
  validates :title, :presence => true
  validates :lyrics, :presence => true
  validates :composer, :presence => true

  belongs_to :band

  has_and_belongs_to_many :albums, :class_name => 'Album', :join_table => 'albums_songs',
                          :foreign_key => :song_id, :association_foreign_key => :album_id
end
