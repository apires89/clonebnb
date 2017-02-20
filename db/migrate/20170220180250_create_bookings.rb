class CreateBookings < ActiveRecord::Migration[5.0]
  def change
    create_table :bookings do |t|
      t.references :user, foreign_key: true
      t.decimal :price
      t.date :start_date
      t.date :end_date
      t.integer :num_of_persons

      t.timestamps
    end
  end
end
