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
    return "duplicate username" if DatabaseConnection.safe_select_all(table: 'users', column: 'username', value: username).any?
    return "duplicate email" if DatabaseConnection.safe_select_all(table: 'users', column: 'email', value: email).any?
    hashed_password = BCrypt::Password.create(password)
    results = DatabaseConnection.safe_insert(table: 'users', columns: ['name', 'username', 'email', 'password'],
                                            values: [name, username, email, hashed_password]).first
    User.new(id: results['id'], name: results['name'], email: results['email'], username: results['username'])
  end

  def self.authenticate(email:, password:)
    results = DatabaseConnection.safe_select_all(table: 'users', column: 'email', value: email).first
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
