def create_user
  User.create(name: "Ollie", email: "ollie@gmail.com", username: "Ollie", password: "password123")
end

def create_user_and_listing 
  user = User.create(name: "Anna", email: "anna@gmail.com", username: "acav", password: "password123")
  Listing.create(name: 'My other place', description: '2 bed', price_per_night: 200, user_id: user.id)
end
