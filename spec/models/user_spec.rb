describe User do
	context 'validations' do
	  it { should have_many(:ratings_given)}
	  it { should have_many(:bookings) }
	  it { should have_many(:reviews) }
	  it { should have_many(:written_reviews)}
	  it { should have_many(:rates_without_dimension) }
	end

	context 'active model' do
  it { is_expected.to validate_presence_of(:username) }
  it { is_expected.to validate_uniqueness_of(:username) }
  it { is_expected.to validate_presence_of(:first_name) }
  it { is_expected.to validate_presence_of(:last_name) }
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_length_of(:password).is_at_least(6) }
  it { is_expected.to validate_length_of(:password).is_at_most(20) }
	end

  before(:each) do
    @user1= User.create!(username: Faker::Internet.user_name, password: "passwords", first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, description: Faker::StarWars.quote, email: Faker::Internet.email, genres: Faker::Book.genre)
    @user2= User.create!(username: Faker::Internet.user_name, password: "passwords", first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, description: Faker::StarWars.quote, email: Faker::Internet.email, genres: Faker::Book.genre)
    @user3= User.create!(username: Faker::Internet.user_name, password: "passwords", first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, description: Faker::StarWars.quote, email: Faker::Internet.email, genres: Faker::Book.genre)
    @studio1= Studio.create!(name: "Studio1", owner: @user1, full_address: "351 W Hubbard St, Chicago, IL 60654", description: "I hate this test", price: 500, website:"http://wikijamz.herokuapp.com")
    @availability_future= Availability.create!(start_time: "2016-04-26 01:00:00", end_time: "2016-04-26 20:00:00", studio: @studio1)
    @availability_past = Availability.create!(start_time: "2016-01-26 01:00:00", end_time: "2016-01-26 20:00:00", studio: @studio1)
    @booking_future = Booking.create(start_time: '2016-04-26 01:00:00.000000000 +0000', end_time: '2016-04-26 02:00:00.000000000 +0000', user: @user1, availability: @availability_future)
    @booking_past = Booking.create(start_time: '2016-01-26 01:00:00.000000000 +0000', end_time: '2016-01-26 02:00:00.000000000 +0000', user: @user1, availability: @availability_future)
    @user1.rate(2, @user3)
    @user1.rate(4, @user2)
  end

  context '#has_studios' do
    it 'returns true if a user has studios' do
      expect(@user1.has_studios).to eq true
    end
  end

  context '#future_bookings' do
    it 'returns an array of future bookings without past bookings' do
      expect(@user1.future_bookings).to eq [@booking_future]
    end
  end

  context '#past_bookings' do
    it 'returns an array of future bookings without past bookings' do
      expect(@user1.past_bookings).to eq [@booking_past]
    end
  end

  context '#average_rating' do

    it 'returns the average of any ratings of the user' do
      expect(@user1.average_rating).to eq 3
    end
  end
end

