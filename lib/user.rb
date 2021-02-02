class User

  attr_reader :name, :email, :username, :id

  def initialize(id:, name:, email:, username:)
    @id = id
    @name = name
    @email = email
    @username = username
  end

  def self.create(name:, email:, username:, password:)
    results = DatabaseConnection.query("INSERT INTO users (name, username, email, password)
                                      VALUES ('#{name}', '#{username}', '#{email}', '#{password}')
                                      returning id, name, username, email").first
    User.new(id: results['id'], name: results['name'], email: results['email'], username: results['username'])
  end

  def self.authenticate(email:, password:)
    results = DatabaseConnection.query("SELECT * FROM users WHERE email = '#{email}';").first
    return false unless results
    results['password'] == password
  end

end
