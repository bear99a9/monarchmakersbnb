require 'database_connection'

describe DatabaseConnection do 
  describe '.setup' do 
    it 'sets up a connection to the database' do 

      expect(PG).to receive(:connect).with(dbname: 'mmbb_test')

      DatabaseConnection.setup('mmbb_test')
  
    end
  end

  describe '.query' do 
    it 'executes a query via PG' do
      connection = DatabaseConnection.setup('mmbb_test')

      expect(connection).to receive(:exec).with('SELECT * FROM listing;')

      DatabaseConnection.query('SELECT * FROM listing;')
    end
  end
end