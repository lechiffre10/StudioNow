describe User do
	context 'validations' do
	  it { should have_many(:ratings) }
	  it { should have_many(:bookings) }
	  it { should have_many(:reviews) }
	  it { should have_many(:written_reviews)}
	  it { should have_many(:ratings) }
	  it { should have_many(:submitted_ratings)}
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
end

