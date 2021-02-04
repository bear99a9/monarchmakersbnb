feature "making a booking" do
  scenario "click through from /listings to /listings/:id" do
    anna = create_anna
    listing = create_listing(user_id: anna.id)
    create_user_and_sign_in
    click_link(listing.name)
    expect(current_path).to eq "/listings/#{listing.id}"
  end
end
