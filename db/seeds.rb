User.destroy_all
Studio.destroy_all
Review.destroy_all
Rate.destroy_all
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

studio_names = ["Shigeto Studios", 'Abbey Road Studios', 'Muscle Shoals Sound Studio', 'Trident Studios', 'Sunset Sound Recorders', 'Headley Grange', 'Electric Lady Studios', 'Chase Park Transduction', 'Hans Zimmer’s Music Lair', "Lee 'Scratch' Perry's Black Ark"]

studio_descriptions = [
  'In three short years, Michigan native Zach Saginaw (a.k.a. Shigeto) has made grand steps to evolve his craft as both a producer and a live performer. On his forthcoming third full-length, No Better Time Than Now, Saginaw has graciously expanded the sound palette heard in his earlier bedroom-born beats, offering a much more organic sonic landscape in the process. His newest compositions find interlocking layers of real-world percussion meeting rich, bluesy keys and entrancing flashes of Shigeto himself behind the drumkit.',
  'The studio itself doesn’t stand out particularly from the rest of the buildings around it, and it sits in a fairly quiet posh northwestern London suburb. If it weren’t for the tourists crowding the crosswalk and the Beatles-related graffiti covering its outer gate, one might pass and never notice it. The most famous image of Abbey Road is of course the crosswalk right outside the studio.',
  'Muscle Shoals may be best known for a song that wasn’t recorded at Muscle Shoals: Lynyrd Skynyrd’s “Sweet Home Alabama.” One of the lines is “Now Muscle Shoals has got the Swampers / And they been known to pick a song or two.” Muscle Shoals was formed when a band, the Muscle Shoals Sound Rhythm Section (nicknamed the Swampers) broke away from the great FAME Studios nearby and formed their own.',
  'It’s hard to understate how important London studios were to rock ‘n’ roll in the ’60s and ’70s, and high among those studios was Trident. Tucked back in an alley in London’s posh Soho neighborhood, Trident is barely noticeable from the street, and it takes a little bit of searching to even realize it’s a studio.',
  'On the other side of the world, we have Sunset Sound Recorders, on Sunset Boulevard in Hollywood, California. It was originally built for recording the music to Walt Disney movies, and you can thank them for Mary Poppins, Bambi, and 101 Dalmatians, but they went on to much greater rock heights.',
  'Headley Grange is a former poorhouse in Headley, England, and it gets on this list for a single reason: its stairwell. During a recording session in the room next door, Jimmy Page was trying out the riff to “When the Levee Breaks,” when the crew started setting up John Bonham’s drum kit in the hall. He went out, start playing, and they recorded it from the stairwell. The result is one of rock’s best ever sounds. Bad Company, Fleetwood Mac, Genesis, and Peter Frampton recorded here as well.',
  'Electric Lady Studios (as you’ve probably guessed) was founded by Jimi Hendrix after how much it cost him to record his epic album Electric Ladyland. Hendrix was only able to use the studio for four weeks before he died, but the studio, in New York’s Greenwich Village, is still very much in use.',
  'Athens, Georgia, has become synonymous with awesome music, and one of its most prolific studios is Chase Park Transduction. It’s recorded the granddaddy of Athens rock bands, REM, as well as acts like Bright Eyes, Deerhunter, Animal Collective, and Queens of the Stone Age.',
  'You may not have heard of Hans Zimmer, but you’ve definitely listened to him. Zimmer is the German composer known for writing the scores to movies like Gladiator, The Dark Knight, Inception, and The Lion King. I’ve always been a fan of his music — try listening to The Dark Knight when you’re trying to get some work done, it’s second only to Daft Punk’s Alive — but I never knew he had an awesome pad like this. It looks like what I imagined Hogwarts looking like. Yes, those are skull lamps, and those aren’t bookshelves in the back — that’s a synthesizer.',
  'Easily the most fascinating studio on this list is Lee “Scratch” Perry’s Black Ark Studio in Kingston, Jamaica. While not quite as mainstream, and definitely more low-tech than nearby Studio One, the Black Ark was known for Perry’s innovative producing techniques, and also for his incredibly strange behavior. He was known for blowing ganja smoke into the tape decks, burying tapes, and spraying the unprotected tapes with blood, urine, and whiskey to “bless” them. ']

studios = 10.times.map do
  Studio.create!(name: studio_names.pop, owner: studio_owners.rotate![0], full_address: addresses.pop, description: studio_descriptions.pop, price: nums.rotate![0], website: Faker::Internet.url)
end

15.times.map do
  users.sample.rate(rand(1..5), studio_owners.rotate![0])
end

15.times.map do
  studios.sample.rate(rand(1..5), users.rotate![0])
end

15.times.map do
  users.sample.reviews.create!(content: Faker::Hipster.sentence(rand(3..20)), reviewer: studio_owners.sample)
end

15.times.map do
  studio_owners.sample.reviews.create!(content: Faker::Hipster.sentence(rand(3..20)), reviewer: studio_owners.sample)
end


studios.each do |studio|
  studio.availabilities.create(start_time: '2016-03-17T08:00:00.000Z', end_time: '2016-03-17T10:00:00.000Z')
  studio.availabilities.create(start_time: '2016-03-18T07:00:00.000Z', end_time: '2016-03-18T22:00:00.000Z')
  studio.availabilities.create(start_time: '2016-03-19T07:00:00.000Z', end_time: '2016-03-19T19:00:00.000Z')
  studio.availabilities.create(start_time: '2016-03-20T08:00:00.000Z', end_time: '2016-03-20T18:00:00.000Z')
  studio.availabilities.create(start_time: '2016-03-21T06:00:00.000Z', end_time: '2016-03-21T17:00:00.000Z')
  studio.availabilities.create(start_time: '2016-03-22T10:00:00.000Z', end_time: '2016-03-22T22:00:00.000Z')
  studio.availabilities.create(start_time: '2016-03-23T06:00:00.000Z', end_time: '2016-03-23T23:00:00.000Z')
  studio.availabilities.create(start_time: '2016-03-24T04:00:00.000Z', end_time: '2016-03-24T10:00:00.000Z')
  studio.availabilities.create(start_time: '2016-03-25T03:00:00.000Z', end_time: '2016-03-25T10:00:00.000Z')
  studio.availabilities.create(start_time: '2016-03-26T10:00:00.000Z', end_time: '2016-03-26T21:00:00.000Z')
  studio.availabilities.create(start_time: '2016-03-27T11:00:00.000Z', end_time: '2016-03-27T14:00:00.000Z')
  studio.availabilities.create(start_time: '2016-03-28T08:00:00.000Z', end_time: '2016-03-28T10:00:00.000Z')
  studio.availabilities.create(start_time: '2016-03-01T08:00:00.000Z', end_time: '2016-03-01T10:00:00.000Z')
  studio.availabilities.create(start_time: '2016-03-02T08:00:00.000Z', end_time: '2016-03-02T10:00:00.000Z')
  studio.availabilities.create(start_time: '2016-03-03T08:00:00.000Z', end_time: '2016-03-03T10:00:00.000Z')
  studio.availabilities.create(start_time: '2016-03-04T08:00:00.000Z', end_time: '2016-03-04T10:00:00.000Z')
  studio.availabilities.create(start_time: '2016-03-05T08:00:00.000Z', end_time: '2016-03-05T10:00:00.000Z')
  studio.availabilities.create(start_time: '2016-03-06T08:00:00.000Z', end_time: '2016-03-06T10:00:00.000Z')
  studio.availabilities.create(start_time: '2016-03-07T08:00:00.000Z', end_time: '2016-03-07T10:00:00.000Z')
  studio.availabilities.create(start_time: '2016-03-08T08:00:00.000Z', end_time: '2016-03-08T10:00:00.000Z')
  studio.availabilities.create(start_time: '2016-03-09T08:00:00.000Z', end_time: '2016-03-09T10:00:00.000Z')
  studio.availabilities.create(start_time: '2016-03-10T08:00:00.000Z', end_time: '2016-03-10T10:00:00.000Z')

end



availabilities = Availability.all.shuffle


# 40.times.map do
#   studios.rotate![0].availabilities.to_a.rotate![0].bookings.create(user: users.sample, start_time: availabilities.first.start_time, end_time: availabilities[0].start_time + 60.minutes, total_price: 100.00)
# end

30.times.map do
  photo_number = rand(1..22).to_s
  studios.rotate![0].images.create(media: File.open("app/assets/images/studio_photos/#{photo_number}.jpg"))
end

15.times.map do
  conversation = users.rotate![0].originated_conversations.create(originator_id: users[0].id, recipient_id: studio_owners.rotate![0].id)
  rand(2..5).times do
    conversation.messages.create(sender_id: users[0].id, content: Faker::Hipster.sentence(rand(3..20)))
    conversation.messages.create(sender_id: studio_owners[0].id, content: Faker::Hipster.sentence(rand(3..20)))
  end
end




