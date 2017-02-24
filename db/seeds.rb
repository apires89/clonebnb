# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Booking.destroy_all
BookingSlot.destroy_all
Room.destroy_all
User.destroy_all
Review.destroy_all

30.times do |i|
  user = User.new({
    phone_number: Faker::PhoneNumber.cell_phone,
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name
    })
  user.email = "test#{i}@example.com"
  user.password = 'password'
  user.password_confirmation = 'password'
  user.save!
  user.facebook_picture_url = Faker::Avatar.image
  user.save!
  if i.even?
    room = Room.new({
        name: Faker::LordOfTheRings.location,
        home_type: ['apartment', 'real', 'mansion'].sample,
        room_type: ['double', 'single', 'whole apertment'].sample,
        address: Faker::Address.street_address,
        price: rand(40) * 5,
        bedrooms: (1..5).to_a.sample,
        accomodate: rand(5) + 1,
        summary: Faker::Lorem.paragraph(4, false, 4),
        description: Faker::Lorem.sentence,
        has_tv: rand < 0.5,
        has_kitchen: rand < 0.5,
        has_aircon: rand < 0.5,
        has_heating: rand < 0.9,
        has_wifi: rand < 0.7,
        bathrooms: rand(3) + 1
      })
    room.user = user
    room.save!
    pic_urls = [
        "http://amari.azureedge.net/phuket/hotel-photos/deluxe-room-1.jpg",
        "https://s-media-cache-ak0.pinimg.com/originals/cc/1f/fa/cc1ffa4845ce338a5c634b82e11c0db2.jpg",
        "http://www.homebase.co.uk/cmsresource/image/69400/landscape_ratio7x3/700/300/7eadf37e43942ee4aec791a13dd171ab/Cj/bathroom-suites---static---header-image-hbo189854.jpg",
        "http://www.ikea.com/gb/en/images/rooms/ikea-beauty-on-the-outside-calmness-on-the-inside__1364309640766-s4.jpg",
        "http://www.whitsundayterraces.com/images_large/balcony_gets_audience.jpeg"
    ]
    room.photo_urls = pic_urls
    room.save!
    day = Date.today
    day = day + rand(40)
    base_price = rand(50) + 10
    (rand(3) + 1).times do
      season_price = base_price + (rand(5) + 1) * 5
      (rand(30) + 1).times do
        slot = BookingSlot.new(date: day.to_s(:db), day_price: season_price)
        slot.room = room
        slot.save!
        day = day + 1
      end
    end
  end
end

Room.all.each do |room|
  rand(5..30).times do  |i|
    review = Review.new({
      star: rand(1..5),
      description: Faker::Lorem.paragraph(4, false, 4),
    })
    review.user = User.all.sample
    review.room = room
    review.save!
  end
end

User.all.each do |user|
  room = Room.all.sample
  booking = Booking.new
  booking_slot = room.booking_slots.sample
  days = rand(7) + 1
  date = booking_slot.date
  booking.start_date = date
  booking.end_date = (date + days)
  booking.num_of_persons = rand(room.accomodate) + 1
  booking.user = user
  booking.room = room
  booking.save
end


