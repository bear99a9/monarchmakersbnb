require './lib/database_connection'

ENV['ENVIRONMENT'] == 'test' ? DatabaseConnection.setup('mmbb_test') : DatabaseConnection.setup('mmbb')
