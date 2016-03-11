describe Booking do
	context 'associations' do 
	  it { should belong_to(:user)}
	  it { should belong_to(:availability)}
	  it { should have_one(:studio)}
	end


	context 'active model' do
		  it { is_expected.to validate_presence_of(:start_time) }
		  it { is_expected.to validate_presence_of(:end_time) }
	end
end
