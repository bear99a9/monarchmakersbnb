def create_user_and_sign_in
  visit('/')
  User.create(name: "name", email: "test@test.com", username: "username", password: "password123" )

  fill_in('email', with: "test@test.com")
  fill_in('password', with: "password123")
  click_button('Log in')
end
