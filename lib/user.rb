class User

  attr_reader :name, :email, :username, :id

  def initialize(id, name, email, username)
    @id = id
    @name = name
    @email = email
    @username = username
  end

  def self.create(name, email, username, password)
    results = DatabaseConnection.query("INSERT INTO users (name, username, email, password)
                                      VALUES ('#{name}', '#{username}', '#{email}', '#{password}')
                                      returning id, name, username, email").first
    User.new(results['id'], results['name'], results['email'], results['username'])
  end

end
