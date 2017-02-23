class Room < ApplicationRecord

  searchkick
  attr_accessor :start_date
  attr_accessor :end_date
  attr_accessor :price
  belongs_to :user
  has_many :booking_slots, dependent: :destroy
  has_many :bookings, dependent: :destroy
  has_many :reviews, dependent: :destroy
  validates :name, :home_type, :room_type, :accomodate, :bedrooms, :bathrooms, :summary, :address, presence: true
  validates :summary, length: {maximum: 500}
  validates :name, length: {maximum: 100}

  has_attachments :photos, maximum: 10
  geocoded_by :address
  after_validation :geocode, if: :address_changed?

end
