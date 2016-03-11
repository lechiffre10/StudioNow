describe Availability do
	context 'associations' do 
	  it { should belong_to(:studio)}
	  it { should have_many(:bookings)}
	end


	context 'active model' do
		  it { is_expected.to validate_presence_of(:start_time) }
		  it { is_expected.to validate_presence_of(:end_time) }
	end
end
