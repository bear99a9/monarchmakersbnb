def create_ollie
  User.create(name: "Ollie", email: "ollie@gmail.com", username: "Ollie", password: "password123")
end

def create_anna
  User.create(name: "Anna", email: "anna@gmail.com", username: "acav", password: "password123")
end 

def create_listing(user_id:)
  Listing.create(name: 'My other place', description: '2 bed', price_per_night: 200, user_id: user_id)
end
