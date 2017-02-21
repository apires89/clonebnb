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

10.times do |i|
  user = User.new
  user.email = "test#{i}@example.com"
  user.password = 'password'
  user.password_confirmation = 'password'
  user.save!
  if i.even?
    room = Room.new({
        home_type: ['apartment', 'real', 'mansion'].sample,
        room_type: ['double', 'single', 'whole apertment'].sample,
        address: Faker::Address.street_address,
        price: rand(40) * 5,
        bedrooms: (1..5).to_a.sample,
        accomodate: rand(5) + 1,
        summary: Faker::Lorem.paragraph(4, false, 4),
        has_tv: rand < 0.5,
        has_kitchen: rand < 0.5,
        has_aircon: rand < 0.5,
        has_heating: rand < 0.9,
        has_wifi: rand < 0.7,
        bathrooms: rand(3) + 1
      })
    room.user = user
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

User.all.each do |user|
  room = Room.all.sample
  booking = Booking.new
  booking_slot = room.booking_slots.sample
  days = rand(7)
  date = booking_slot.date
  booking.start_date = date.to_s(:db)
  booking.end_date = (date + days).to_s(:db)
  booking.num_of_persons = rand(room.accomodate) + 1
  booking.user = user
  is_free = (0..(days - 1)).to_a.all? do |i|
    booking_slot = room.booking_slots.where('date = ?', (date + i).to_s(:db)).first
    booking_slot && !booking_slot.booking
  end
  if is_free
    booking.save!
    (0..(days - 1)).to_a.each do |i|
      booking_slot = room.booking_slots.where('date = ?', (date + i).to_s(:db)).first
      booking_slot.booking = booking
      booking_slot.save!
    end
  end
end
