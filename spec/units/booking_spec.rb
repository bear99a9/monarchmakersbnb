describe Booking do

  let(:user) { create_user }
  let(:listing) { create_user_and_listing }
  # let(:results) { persisted_data(id: new_user.id, table: 'booking') }
  subject(:booking) { described_class.create(visitor_id: user.id, listing_id: listing.id) }
  describe '.create' do 
    it 'returns a booking' do 
      expect(booking.visitor_id).to eq user.id
      expect(booking.listing_id).to eq listing.id
      expect(booking.status).to eq 'pending'
    end
  end

  describe '.all' do
    it 'lists all bookings' do 
      new_booking = Booking.create(visitor_id: user.id, listing_id: listing.id)
      Booking.create(visitor_id: user.id, listing_id: listing.id)

      bookings = Booking.all

      expect(bookings.length).to eq 2
      expect(bookings).to all(be_an_instance_of(Booking))
      expect(bookings.last.id).to eq new_booking.id
      expect(bookings.last.visitor_id).to eq new_booking.visitor_id
      expect(bookings.last.listing_id).to eq new_booking.listing_id
    end
  end
end


