require 'bcrypt'

class User

  attr_reader :name, :email, :username, :id

  def initialize(id:, name:, email:, username:)
    @id = id
    @name = name
    @email = email
    @username = username
  end

  def self.create(name:, email:, username:, password:)
    return "duplicate username" if DatabaseConnection.query("select * from users where username = '#{username}';").any?
    return "duplicate email" if DatabaseConnection.query("select * from users where email = '#{email}';").any?
    hashed_password = BCrypt::Password.create(password)
    results = DatabaseConnection.query("INSERT INTO users (name, username, email, password)
                                      VALUES ('#{name}', '#{username}', '#{email}', '#{hashed_password}')
                                      returning id, name, username, email").first
    User.new(id: results['id'], name: results['name'], email: results['email'], username: results['username'])
  end

  def self.authenticate(email:, password:)
    results = DatabaseConnection.query("SELECT * FROM users WHERE email = '#{email}';").first
    return unless results
    return unless BCrypt::Password.new(results['password']) == password
    User.new(id: results['id'], name: results['name'], email: results['email'], username: results['username'])

  end

  def self.find(id:)
    return nil unless id
    results = DatabaseConnection.query("SELECT * FROM users WHERE id = '#{id}';").first
    User.new(id: results['id'], name: results['name'], email: results['email'], username: results['username'])
  end

end
