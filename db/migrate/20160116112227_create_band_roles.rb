class CreateBandRoles < ActiveRecord::Migration
  def change
    create_table :band_roles do |t|
      t.string :role, null: false
      t.references :band
      t.references :user
    end
    add_index :band_roles, :band_id
    add_index :band_roles, :user_id
  end
end
