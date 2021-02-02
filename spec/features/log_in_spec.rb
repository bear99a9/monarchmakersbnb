feature 'Log in' do
  scenario 'A user can log in' do
    create_user_and_sign_in

    expect(current_path).to eq('/listings')
    expect(page).to have_content('Hi test@test.com')
  end
end
