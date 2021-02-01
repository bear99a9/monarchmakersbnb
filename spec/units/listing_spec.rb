require 'listing'

describe Listing do

  describe '.create' do
    it 'creates a listing' do
      listing = Listing.create(name: "My place", description: "1 bed", price_per_night: 400)

      expect(listing).to be_a(Listing)
      expect(listing.name).to eq("My place")
      expect(listing.description).to eq("1 bed")
      expect(listing.price_per_night).to eq(400)
    end

    it 'adds it to the database' do
      listing = Listing.create(name: "My place", description: "1 bed", price_per_night: 400)
      persisted_data = persisted_data(id: listing.id)

      expect(listing.id).to eq(persisted_data['id'])
    end
  end
end
