feature 'Accepting and rejecting bookings' do

  context 'when someone books one of your properties' do
    let(:anna) { create_anna }
    let(:listing) { create_listing(user_id: anna.id) }

    before do
      anna
      listing
      create_user_and_sign_in
      click_link(listing.name)
      click_button('Book')
      click_button('Back to listings')
      click_button('Log out')
      fill_in('email', with: anna.email)
      fill_in('password', with: 'password123')
      click_button('Log in')
    end

    scenario 'you get a flash notice on your homepage' do
      click_link 'One of your listings has a new booking'
      expect(current_path).to eq "/users/#{anna.id}/listings"
      expect(page.status_code).to eq 200
    end

    scenario 'your listings page shows bookings on your properties' do
      visit("/users/#{anna.id}/listings")
      expect(page).to have_content listing.name
      within(".listing_#{listing.id}") do
        expect(page).to have_content("name wants to book this property")
        expect(page).to have_button("Approve")
        expect(page).to have_button("Deny")
      end
    end

    scenario 'you reject a booking' do
      visit("/users/#{anna.id}/listings")
      within(".listing_#{listing.id}") do
        click_button "Deny"
        expect(current_path).to eq "/users/#{anna.id}/listings"
        expect(page.status_code).to eq 200
        expect(page).to have_content "name's request was denied"
        expect(page).not_to have_button "Approve"
        expect(page).not_to have_button "Deny"
      end
    end

  end

end
