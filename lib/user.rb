class User

  attr_reader :name, :email, :username

  def initialize(name, email, username)
    @name = name
    @email = email
    @username = username
  end

  def self.create(name, email, username, password)
    User.new(name, email, username)
  end

end
