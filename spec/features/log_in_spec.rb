feature 'Log in' do
  before { create_user_and_sign_in }

  scenario 'A user can log in' do
    expect(current_path).to eq('/listings')
    # The below will need to change once we have find method
    expect(page).to have_content('Hi name')
  end

  scenario 'User sees right things when logged in' do
    expect(page).to have_button('Log out')
    expect(page).not_to have_button('Log in')
    expect(page).not_to have_button('Sign up')
    expect(page).to have_button('Add Listing')
  end

end
