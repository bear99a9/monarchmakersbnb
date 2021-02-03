# frozen_string_literal: true

require 'listing'

describe Listing do
  let(:user) { User.create(name: "Ollie", email: "ollie@gmail.com", username: "Ollie", password: "password123") }
  let(:name) { 'My place' }
  let(:description) { '1 bed' }
  let(:price_per_night) { 400 }
  let(:user_id) { user.id }
  subject(:listing) { described_class.create(name: name, description: description, price_per_night: price_per_night, user_id: user_id) }

  describe '.create' do
    it 'creates a listing' do

      #listing = Listing.create(name: 'My place', description: '1 bed', price_per_night: 400)

      expect(listing).to be_a(Listing)
      expect(listing.name).to eq('My place')
      expect(listing.description).to eq('1 bed')
      expect(listing.price_per_night).to eq(400)
    end

    it 'adds it to the database' do
      #listing = Listing.create(name: 'My place', description: '1 bed', price_per_night: 400)
      persisted_data = persisted_data(id: listing.id, table: 'listing')

      expect(listing.id).to eq(persisted_data['id'])
      expect(listing.name).to eq(persisted_data['name'])
      expect(listing.description).to eq(persisted_data['description'])
      expect(listing.price_per_night).to eq(persisted_data['price_per_night'].to_i)
    end
  end

  describe '.all' do
    it 'lists all listings' do
      listing = Listing.create(name: name, description: description, price_per_night: price_per_night, user_id: user.id)
      Listing.create(name: 'My other place', description: '2 bed', price_per_night: 200, user_id: user.id)
      listings = Listing.all

      expect(listings).to all(be_an_instance_of(Listing))
      expect(listings.length).to eq 2
      expect(listings.last.id).to eq(listing.id)
      expect(listings.last.name).to eq(listing.name)
      expect(listings.last.description).to eq(listing.description)
      expect(listings.last.price_per_night).to eq(listing.price_per_night.to_i)
    end
  end
end
