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
    #not have log in
    #not have sign up
    # have create listing button
    # have sign out button 
  end
end
