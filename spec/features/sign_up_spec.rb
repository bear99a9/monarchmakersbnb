feature 'Sign up' do
  scenario 'A user can sign up' do
    visit('/')
    click_button("Sign up")
    expect(current_path).to eq('/users/new')

    fill_in('email', with: "test@test.com")
    fill_in('password', with: "password123")
    fill_in('name', with: "John Smith")
    fill_in('username', with: "jsmith1")

    click_button('Submit')

    expect(current_path).to eq('/listings')
    expect(page).to have_content('Hi John Smith')

    expect(page).not_to have_button("Log in")
    expect(page).not_to have_button("Sign up")
    expect(page).to have_button("Log out")
    expect(page).to have_button("Add Listing")
  end

  # scenario 'sign up with no password' do
  #   visit('/users/new')
  #
  #   fill_in('email', with: "test@test.com")
  #   # fill_in('password', with: "")
  #   fill_in('name', with: "John Smith")
  #   fill_in('username', with: "jsmith1")
  #
  #   click_button('Submit')
  #   expect(current_path).to eq('/users/new')
  #   fill_in('password', with: "1234")
  #
  #   click_button('Submit')
  #
  #   expect(current_path).to eq('/listings')
  #   # message =
  #   #   page.find('#password').native.attribute("validationMessage")
  #   #
  #   # expect(message).to eq "Please fill out this field."
  #
  #
  # end
end
