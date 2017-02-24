class Room < ApplicationRecord
  include AlgoliaSearch

  algoliasearch do
    # list of attribute used to build an Algolia record
    attributes :name, :address, :description

    # the `searchableAttributes` (formerly known as attributesToIndex) setting defines the attributes
    # you want to search in: here `title`, `subtitle` & `description`.
    # You need to list them by order of importance. `description` is tagged as
    # `unordered` to avoid taking the position of a match into account in that attribute.
    searchableAttributes ['name', 'address', 'unordered(description)']

    # the `customRanking` setting defines the ranking criteria use to compare two matching
    # records in case their text-relevance is equal. It should reflect your record popularity.
    #customRanking ['desc(likes_count)']
  end

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
