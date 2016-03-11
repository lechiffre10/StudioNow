describe Image do
	context 'associations' do 
	  it { should belong_to(:studio)}
	end


	context 'active model' do
		it { should have_attached_file(:media) }
		it { should validate_attachment_presence(:media) }
	  it { should validate_attachment_content_type(:media).
                allowing('image/png', 'image/gif', 'image/jpeg', 'image/tiff') }		
	end
end
