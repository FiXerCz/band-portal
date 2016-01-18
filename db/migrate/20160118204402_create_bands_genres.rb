class CreateBandsGenres < ActiveRecord::Migration
  def change
    create_table :bands_genres, :id => false do |t|
      t.references :band
      t.references :genre
    end
    add_index :bands_genres, :band_id
    add_index :bands_genres, :genre_id
  end
end
