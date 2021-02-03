describe Booking do
  describe '.create' do 
    it 'returns a booking' do 
      user = create_user
      listing = create_listing
      booking = Booking.create(visitor_id: user.id, listing_id: listing.id, status: 'pending')

      expect(booking.visitor_id).to eq user.id
      expect(booking.listing_id).to eq listing.id
      expect(booking.status).to eq 'pending'
    end
  end
end


