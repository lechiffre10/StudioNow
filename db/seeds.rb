User.destroy_all
Studio.destroy_all


users = 15.times.map do
  User.create!(username: Faker::Internet.user_name, password_digest: "password", first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, description: Faker::Hipster.sentence(rand(3..20)), email: Faker::Internet.email, genres: Faker::Book.genre)
end

studio_owners = 15.times.map do
  User.create!(username: Faker::Internet.user_name, password_digest: "password", first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, description: Faker::StarWars.quote, email: Faker::Internet.email, genres: Faker::Book.genre)
end

nums = [40.00, 35.50, 25.25, 88.50, 90.00, 33.40, 50.00, 55.00]

studios = 15.times.map do
  Studio.create!(name: Faker::Team.name, user: studio_owners.rotate![0], address: Faker::Address.street_address, lat: Faker::Address.latitude, lng: Faker::Address.longitude, city: Faker::Address.city, state: Faker::Address.state, description: Faker::Hipster.sentence(rand(3..20)), price: nums.rotate![0], website: Faker::Internet.url)
end

15.times.map do
  users.sample.rating.create!(value: rand(1..5), studios.sample)
end

