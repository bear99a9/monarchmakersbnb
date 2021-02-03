# frozen_string_literal: true

feature 'adding a listing' do
  scenario 'go to home page and add a listing' do
    create_user_and_sign_in
    click_button 'Add Listing'

    expect(current_path).to eq '/listings/add'
    expect(page).to have_content 'Add new listing'

    fill_in('name', with: '1 sussex way')
    fill_in('description', with: '1 bed, very dirty')
    fill_in('price_per_night', with: 300)
    click_button 'Submit'

    expect(current_path).to eq '/listings'
    expect(page).to have_content '1 sussex way'
  end
end
