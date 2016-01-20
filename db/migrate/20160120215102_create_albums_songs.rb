class CreateAlbumsSongs < ActiveRecord::Migration
  def change
    create_table :albums_songs, :id => false do |t|
      t.references :album
      t.references :song
    end
    add_index :albums_songs, :album_id
    add_index :albums_songs, :song_id
  end
end
