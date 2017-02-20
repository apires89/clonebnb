class CreateBookingSlots < ActiveRecord::Migration[5.0]
  def change
    create_table :booking_slots do |t|
      t.date :date
      t.decimal :day_price
      t.references :booking, foreign_key: true

      t.timestamps
    end
  end
end
