class CreatePerformers < ActiveRecord::Migration
  def change
    create_table :performers do |t|
      t.references :concert
      t.references :band
      t.boolean :confirmed
    end
    add_index :performers, :concert_id
    add_index :performers, :band_id
  end
end
