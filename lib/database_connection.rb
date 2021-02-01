require "pg"

class DatabaseConnection
  # def self.setup(dbname)
  #
  # end

  def self.query(sql)
    if ENV['RACK_ENV'] == 'test'
      connection = PG.connect(dbname: 'mmbb_test')
      connection.query(sql)
    else
      connection = PG.connect(dbname: 'mmbb')
      connection.query(sql)
    end
  end
end
