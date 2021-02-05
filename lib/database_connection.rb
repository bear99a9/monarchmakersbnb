# frozen_string_literal: true

require 'pg'

class DatabaseConnection

  def self.setup(dbname)
    @connection = PG.connect(dbname: dbname)
  end

  # class << self
  #   attr_reader :connection
  # end

  def self.query(sql)
    @connection.exec(sql)
  end

  def self.safe_select_all(table:, column:, value:)
    @connection.prepare('select_statement', prepare_sql_select_string(table, column))
    results = @connection.exec_prepared('select_statement', [value])
    DatabaseConnection.query('DEALLOCATE select_statement')
    results
  end

  def self.safe_insert(table:, columns:, values:)
    @connection.prepare('insert_statement', prepare_sql_insert_string(table, columns, values))
    results = @connection.exec_prepared('insert_statement', values)
    DatabaseConnection.query('DEALLOCATE insert_statement')
    results
  end

  def self.prepare_sql_select_string(table, column)
    "select * from #{table} where #{column} = $1"
  end

  def self.prepare_sql_insert_string(table, columns, values)
    value_subs = values.each_with_index.map { |val, ind| "$#{ind + 1}"}.join(',')
    columns_string = columns.join(',')
    return_columns = columns.unshift('id').join(',')
    "insert into #{table} (#{columns_string}) values (#{value_subs}) returning #{return_columns}"
  end


end
