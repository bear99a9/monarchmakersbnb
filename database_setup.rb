require './lib/database_connection.rb'

if ENV['ENVIRONMENT'] == 'test'
  DatabaseConnection.setup('mmbb_test')
else
  DatabaseConnection.setup('mmbb')
end