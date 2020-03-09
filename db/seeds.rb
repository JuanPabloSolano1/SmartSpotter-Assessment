# frozen_string_literal: true

require 'faker'

puts 'Deleting all records'

Participant.delete_all
Booking.delete_all
Room.delete_all
User.delete_all

puts 'Creating rooms'

5.times do
  name = Faker::Games::Pokemon.location
  Room.create!(name: name)
end

user = User.new(name: 'david', password: 'Hello', password_confirmation: 'Hello',email:"juansolano1034@evil-corp.com")
user.save!


user = User.new(name: 'pedro', password: 'Hello', password_confirmation: 'Hello',email:"juansolano1039@evil-corp.com")
user.save!

# user = User.new(name: 'pedro', password: 'Hello', password_confirmation: 'Hello',email:"juansolano1039@evil-cor.com")
# user.save!


puts "User Created"

booking = Booking.new(
  start_time: "14:30",
  end_time: "14:45",
  date: "12/08/2020",
  room_id: 2,
  user_id: 1
)
booking.save!

booking = Booking.new(
  start_time: "14:30",
  end_time: "14:45",
  date: "12/09/2020",
  room_id: 1,
  user_id: 2
)
booking.save!

booking = Booking.new(
  start_time: "14:46",
  end_time: "14:47",
  date: "12/09/2020",
  room_id: 1,
  user_id: 2
)
booking.save!


puts "Booking Created"

puts 'Rooms created'
