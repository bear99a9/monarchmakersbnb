def create_user_and_sign_in
  visit('/')
  User.create("name", "test@test.com", "username", "password123" )

  fill_in('email', with: "test@test.com")
  fill_in('password', with: "password123")
  click_button('Log in')

  expect(current_path).to eq('/listings')
  expect(page).to have_content('Hi test@test.com')
end
