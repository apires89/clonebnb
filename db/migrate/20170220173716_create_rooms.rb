class CreateRooms < ActiveRecord::Migration[5.0]
  def change
    create_table :rooms do |t|
      t.string :home_type
      t.string :room_type
      t.string :address
      t.integer :price
      t.integer :bedrooms
      t.integer :accomodate
      t.text :summary
      t.boolean :has_tv
      t.boolean :has_kitchen
      t.boolean :has_aircon
      t.boolean :has_heating
      t.boolean :has_wifi

      t.timestamps
    end
  end
end
