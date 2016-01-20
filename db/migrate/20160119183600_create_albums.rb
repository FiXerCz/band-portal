class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.string :title
      t.datetime :released
      t.integer :band_id

      t.timestamps null: false
    end
  end
end
