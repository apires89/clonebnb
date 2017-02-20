class AddRoomToBookingSlots < ActiveRecord::Migration[5.0]
  def change
    add_reference :booking_slots, :room, foreign_key: true
  end
end
