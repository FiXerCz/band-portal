class CreateBandsUsers < ActiveRecord::Migration
  def change
    create_table :bands_users, :id => false do |t|
      t.references :band
      t.references :user
    end
    add_index :bands_users, :band_id
    add_index :bands_users, :user_id
  end
end
