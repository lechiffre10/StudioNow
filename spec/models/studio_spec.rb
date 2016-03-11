describe Studio do
	context 'associations' do 
	  it { should have_many(:images) }
	  it { should have_many(:availabilities) }
	end
end

