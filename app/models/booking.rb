class Booking < ApplicationRecord
  belongs_to :user
  has_many :booking_slots, dependent: :nullify
  validates :user, :start_date, :end_date, :num_of_persons, presence: true

end
