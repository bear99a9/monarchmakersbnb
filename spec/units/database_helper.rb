# frozen_string_literal: true

require 'pg'

p 'Setting up test database...'

def truncate_test_database
  connection = PG.connect(dbname: 'mmbb_test')
  connection.exec('TRUNCATE listing, users, booking;')
end

def persisted_data(id:, table:)
  connection = PG.connect(dbname: 'mmbb_test')
  connection.query("SELECT * FROM #{table} WHERE id = #{id};").first
end
