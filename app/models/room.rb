class Room < ApplicationRecord
  attr_accessor :start_date
  attr_accessor :end_date
  attr_accessor :price
  belongs_to :user
  has_many :booking_slots, dependent: :destroy
  has_attachments :photos, maximum: 10

  validates :name, :home_type, :room_type, :accomodate, :bedrooms, :bathrooms, :summary, :address, presence: true
  validates :summary, length: {maximum: 500}


end
