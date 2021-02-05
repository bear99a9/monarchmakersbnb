feature "viewing bookings" do
  # let(:anna) { create_anna }
  # let(:listing) { create_listing(user_id: anna.id) }

  # before do
  #   anna
  #   listing
  #
  #   click_link(listing.name)
  # end

  scenario 'view bookings from listings' do
    create_user_and_sign_in
    click_button('My Bookings')
    expect(current_path).to match /\/users\/.+\/bookings/
    expect(page).to have_content("Here are your bookings")
  end

  scenario 'return to listings from my bookings' do
    create_user_and_sign_in
    click_button('My Bookings')
    click_button('Back')
    expect(current_path).to eq('/listings')
  end
end
