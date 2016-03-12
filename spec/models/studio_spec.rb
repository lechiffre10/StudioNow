describe Studio do
	context 'associations' do 
	  it { should have_many(:images) }
	  it { should have_many(:availabilities) }
	  it { should belong_to(:owner)}
	  it { should have_many(:reviews) }
	  it { should have_many(:ratings) }
	  it { should have_many(:bookings) }
	end


	context 'active model' do
		  it { is_expected.to validate_presence_of(:name) }
		  it { is_expected.to validate_presence_of(:address) }
		  it { is_expected.to validate_presence_of(:city) }
		  it { is_expected.to validate_presence_of(:state) }
		  it { is_expected.to validate_presence_of(:zip_code) }
		  it { is_expected.to validate_presence_of(:price) }
		  it { is_expected.to validate_presence_of(:description) }
	end
end

