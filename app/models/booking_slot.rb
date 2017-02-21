class BookingSlot < ApplicationRecord
  belongs_to :booking
  belongs_to :room
  validates :room, :day_price, :date, presence: true
end
