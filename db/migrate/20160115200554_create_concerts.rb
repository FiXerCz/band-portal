class CreateConcerts < ActiveRecord::Migration
  def change
    create_table :concerts do |t|
      t.string  :title, null: false
      t.string :location, null: false
      t.integer :capacity
      t.datetime :from_date
      t.datetime :to_date
      t.decimal :price, null: false

      t.timestamps null: false
    end
  end
end
