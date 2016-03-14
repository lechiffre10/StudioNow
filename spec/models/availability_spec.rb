describe Availability do
  let(:user)  { User.create!(username: Faker::Internet.user_name, password: "passwords", first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, description: Faker::StarWars.quote, email: Faker::Internet.email, genres: Faker::Book.genre) }
  let(:studio) {Studio.create!(name: "Studio1", owner: user, full_address: "351 W Hubbard St, Chicago, IL 60654", description: "I hate this test", price: 500, website:"http://wikijamz.herokuapp.com")}
    let(:availability) {Availability.create!(start_time: "2016-04-05 01:00:00", end_time: "2016-04-05 18:00:00", studio: studio)}


	context 'associations' do
	  it { should belong_to(:studio)}
	  it { should have_many(:bookings)}
	end


	context 'active model' do
		  it { is_expected.to validate_presence_of(:start_time) }
		  it { is_expected.to validate_presence_of(:end_time) }
	end

  context '#unbooked_times' do
    it 'finds the unbooked times and returns an array' do
      booking = Booking.create!(start_time: "2016-04-05 04:00:00", end_time: "2016-04-05 06:00:00", user: user, availability_id: availability.id)
      expect(availability.unbooked_times).to eq([['2016-04-05 01:00:00.000000000 +0000', '2016-04-05 04:00:00.000000000 +0000'], ['2016-04-05 06:00:00.000000000 +0000', '2016-04-05 18:00:00.000000000 +0000']])
    end
  end
end
