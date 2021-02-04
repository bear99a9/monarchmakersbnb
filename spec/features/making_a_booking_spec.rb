feature "making a booking" do
  let(:anna) { create_anna }
  let(:listing) { create_listing(user_id: anna.id) }

  before do
    anna
    listing
    create_user_and_sign_in
    click_link(listing.name)
  end

  scenario "click through from /listings to /listings/:id" do
    expect(current_path).to eq "/listings/#{listing.id}"
    expect(page.status_code).to eq 200
  end

  scenario "/listings/:id has right things on it" do
    expect(page).to have_content(listing.name)
    expect(page).to have_content(listing.description)
    expect(page).to have_content("£#{listing.price_per_night} per night")
    expect(page).to have_content('Anna')
    expect(page).to have_button("Book")
  end

  scenario "clicking the Book button" do
    click_button("Book")
    expect(page.status_code).to eq 200
    expect(page).to have_content(listing.name)
    expect(page).to have_content(listing.description)
    expect(page).to have_content("£#{listing.price_per_night} per night")
    expect(page).to have_content("Pending")
  end
end
