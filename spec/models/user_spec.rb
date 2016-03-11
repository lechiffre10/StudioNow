describe User do
  it { should have_many(:ratings) }
  it { should have_many(:bookings) }
end

