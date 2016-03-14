describe Studio do
	context 'associations' do
	  it { should have_many(:images) }
	  it { should have_many(:availabilities) }
	  it { should belong_to(:owner)}
	  it { should have_many(:reviews) }
	  it { should have_many(:rates_without_dimension) }
	  it { should have_many(:bookings) }
	end


	context 'active model' do
		  it { is_expected.to validate_presence_of(:name) }
		  it { is_expected.to validate_presence_of(:full_address) }
		  it { is_expected.to validate_presence_of(:price) }
		  it { is_expected.to validate_presence_of(:description) }
	end

	 before(:each) do
    @user1= User.create!(username: Faker::Internet.user_name, password: "passwords", first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, description: Faker::StarWars.quote, email: Faker::Internet.email, genres: Faker::Book.genre)
    @user2= User.create!(username: Faker::Internet.user_name, password: "passwords", first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, description: Faker::StarWars.quote, email: Faker::Internet.email, genres: Faker::Book.genre)
    @studio1= Studio.create!(name: "Studio1", owner: @user1, full_address: "351 W Hubbard St, Chicago, IL 60654", description: "I hate this test", price: 500, website:"http://wikijamz.herokuapp.com")
    @availability_future= Availability.create!(start_time: "2016-04-26 01:00:00", end_time: "2016-04-26 20:00:00", studio: @studio1)
    @availability1= Availability.create!(start_time: "2016-04-05 15:42:04", end_time: "2016-04-05 18:42:04", studio: @studio1)
    @availability_past = Availability.create!(start_time: "2016-01-26 01:00:00", end_time: "2016-01-26 20:00:00", studio: @studio1)
    @studio1.rate(2, @user1)
    @studio1.rate(4, @user2)

  end

	context '#future_availabilities' do
		it 'finds the right availabilities and not the past ones' do
			expect(@studio1.future_availabilities).not_to include(@availability_past)
		end
	end

	context '#sorted_availabilities' do
		it 'finds the right availabilities and not the past ones' do
			expect(@studio1.sorted_availabilities.first).to eq(@availability1)
		end
	end

	context '#average_rating' do
    it 'returns the average of any ratings of the studio' do
      expect(@studio1.average_rating).to eq 3
    end
  end
end

