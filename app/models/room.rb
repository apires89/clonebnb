class Room < ApplicationRecord
  searchkick
  belongs_to :user
  has_many :booking_slots, dependent: :destroy

  validates :home_type, :room_type, :accomodate, :bedrooms, :bathrooms, :summary, :address, presence: true
  validates :summary, length: {maximum: 500}

  has_attachments :photos, maximum: 10
  geocoded_by :address
  after_validation :geocode, if: :address_changed?

end
