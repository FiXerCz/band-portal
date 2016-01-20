class AddBandIdToComments < ActiveRecord::Migration
  def change
    add_column :comments, :band_id, :integer
  end
end
