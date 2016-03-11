describe Review do
	context 'associations' do 
	  it { should belong_to(:reviewable)}
	  it { should belong_to(:reviewer)}
	end


	context 'active model' do
		  it { is_expected.to validate_presence_of(:content) }
	end
end
