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

nums = [40, 35, 25, 88, 90, 33, 50, 55]

addresses = ["351 W Hubbard St, Chicago, IL 60654", "907 Caprice Dr. Shorewood IL, 60404", "15377 Silver Bell Rd. Orland Park, IL 60462", "2833 N Sheffield Ave, Chicago, IL 60657", "900 N. Wood St. Chicago, IL 60622", "16263 West Wyandot Lockport, IL 60441", "908 Caprice Dr. Shorewood, IL 60404", "233 S Wacker Dr, Chicago, IL 60606", "1035 N Western Ave, Chicago, IL 60622", "3159 N Southport Ave, Chicago, IL 60657"]


studios = 10.times.map do
  Studio.create!(name: Faker::Team.name, owner: studio_owners.rotate![0], full_address: addresses.pop, description: Faker::Hipster.sentence(rand(3..20)), price: nums.rotate![0], website: Faker::Internet.url)
end

15.times.map do
  users.sample.ratings.create!(score: rand(1..5), rater: studio_owners.sample)
end

15.times.map do
  studio_owners.sample.ratings.create!(score: rand(1..5), rater: studio_owners.sample)
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

past_availabilities = 30.times.map do
  old_day = rand(10..30)
  studios.rotate![0].availabilities.create!(start_time: Faker::Time.backward(old_day, :morning), end_time: Faker::Time.backward(old_day, :evening))
end



40.times.map do
  studios.rotate![0].availabilities.to_a.rotate![0].bookings.create(user: users.sample, start_time: availabilities.first.start_time, end_time: availabilities[0].start_time + 60.minutes, total_price: 100.00)
end

40.times.map do
  studios.rotate![0].availabilities.to_a.rotate![0].bookings.create(user: users.sample, start_time: past_availabilities.first.start_time, end_time: past_availabilities[0].start_time + 60.minutes, total_price: 100.00)
end

30.times.map do
  photo_number = rand(1..22).to_s
  studios.rotate![0].images.create(media: File.open("app/assets/images/studio_photos/#{photo_number}.jpg"))
end



