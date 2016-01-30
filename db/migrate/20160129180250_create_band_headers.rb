class CreateBandHeaders < ActiveRecord::Migration
  def self.up
    create_table :headers do |t|
      t.integer    :band_id
      t.string     :style
      t.binary     :file_contents
    end
  end

  def self.down
    drop_table :headers
  end
end
