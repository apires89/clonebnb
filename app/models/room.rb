class Room < ApplicationRecord
  belongs_to :user
  has_many :booking_slots, dependent: :destroy
  has_attachment :photo

  validates :home_type, :room_type, :accomodate, :bedrooms, :bathrooms, :summary, :address, presence: true
  validates :summary, length: {maximum: 500}


end
