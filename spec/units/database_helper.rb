require 'pg'

def truncate_table(table)
  connection = PG.connect(dbname: 'mmbb_test')
  connection.query("delete FROM #{table}")
end

def persisted_data(id:)
  connection = PG.connect(dbname: 'mmbb_test')
  connection.query("SELECT * FROM listing WHERE id = #{id};").first
end
