class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :room
  has_many :booking_slots, dependent: :nullify
  validates :user, :room, :start_date, :end_date, :num_of_persons, presence: true
  validate :check_if_slots_available
  after_save :book_slots

  private

  def check_if_slots_available
    errors.add(:start_date, "Start date before end date") if start_date >= end_date
    is_free = (start_date...end_date).to_a.all? do |i|
      booking_slot = room.booking_slots.where('date = ?', i.to_s(:db)).first
      booking_slot && !booking_slot.booking
    end
    if !is_free
      errors.add(:start_date, "Dates not free")
      errors.add(:end_date, "Dates not free")
    end
  end

  def book_slots
    price = 0
    (start_date...end_date).to_a.each do |i|
      booking_slot = room.booking_slots.where('date = ?', i.to_s(:db)).first
      booking_slot.booking = self
      booking_slot.save!
      price += booking_slot.day_price
    end
    self.price = price
  end
end
