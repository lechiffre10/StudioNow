User.destroy_all
Studio.destroy_all
Review.destroy_all
Rating.destroy_all
Availability.destroy_all
Booking.destroy_all


users = 15.times.map do
  User.create!(username: Faker::Internet.user_name, password: "passwords", first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, description: Faker::Hipster.sentence(rand(3..20)), email: Faker::Internet.email, genres: Faker::Book.genre)
end

studio_owners = 15.times.map do
  User.create!(username: Faker::Internet.user_name, password: "passwords", first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, description: Faker::StarWars.quote, email: Faker::Internet.email, genres: Faker::Book.genre)
end

nums = [40.00, 35.50, 25.25, 88.50, 90.00, 33.40, 50.00, 55.00]

studios = 10.times.map do
  addresses = ["5 N Wabash Ave", "907 Caprice Dr.", "15377 Silver Bell Rd.", "351 W Hubbard St", "900 N. Wood St.", "16263 West Wyandot", "908 Caprice Dr.", "233 S Wacker Dr", "233 S Wacker Dr", "3159 N Southport Ave."]
  Studio.create!(name: Faker::Team.name, owner: studio_owners.rotate![0], address: addresses.sample, latitude: Faker::Address.latitude, longitude: Faker::Address.longitude, city: Faker::Address.city, state: Faker::Address.state, description: Faker::Hipster.sentence(rand(3..20)), price: nums.rotate![0], website: Faker::Internet.url, zip_code: Faker::Address.zip_code)
end

15.times.map do
  users.sample.ratings.create!(value: rand(1..5), rater: studio_owners.sample)
end

15.times.map do
  studio_owners.sample.ratings.create!(value: rand(1..5), rater: studio_owners.sample)
end

15.times.map do
  users.sample.reviews.create!(content: Faker::Hipster.sentence(rand(3..20)), reviewer: studio_owners.sample)
end

15.times.map do
  studio_owners.sample.reviews.create!(content: Faker::Hipster.sentence(rand(3..20)), reviewer: studio_owners.sample)
end

availabilities = 30.times.map do
  day = rand(10..30)

  studios.rotate![0].availabilities.create!(start_time: Faker::Time.forward(start_day = day, :morning), end_time: Faker::Time.forward(start_day, :evening))
end

40.times.map do
  studios.rotate![0].availabilities.to_a.rotate![0].bookings.create(user: users.sample, start_time: availabilities.first.start_time, end_time: availabilities[0].start_time + 60.minutes, total_price: 100.00)
end






