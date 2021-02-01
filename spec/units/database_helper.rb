require 'pg'

def persisted_data(id:)
  connection = PG.connect(dbname: 'mmbb_test')
  connection.query("SELECT * FROM listing WHERE id = #{id};").first
end
