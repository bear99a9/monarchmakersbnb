# frozen_string_literal: true

require_relative 'database_connection'

class Listing
  attr_reader :id, :name, :description, :price_per_night

  def initialize(id:, name:, description:, price_per_night:, user_id:)
    @id = id
    @name = name
    @description = description
    @price_per_night = price_per_night
    @user_id = user_id
  end

  def self.create(name:, description:, price_per_night:, user_id:)
    result = DatabaseConnection.query("INSERT INTO listing(name, description,
      price_per_night, user_id) VALUES('#{name}', '#{description}', '#{price_per_night}', '#{user_id}')
      RETURNING id, name, description, price_per_night, user_id;").first

    Listing.new(id: result['id'],
                name: result['name'],
                description: result['description'],
                price_per_night: result['price_per_night'].to_i,
                user_id: result['user_id'])
  end

  def self.all
    results = DatabaseConnection.query('select * from listing order by id desc')
    Listing.map_results(results)
  end

  def self.where(user_id:)
    results = DatabaseConnection.query("select * from listing where user_id = '#{user_id}'")
    Listing.map_results(results)
  end

  private

  def self.map_results(results)
    results.map do |row|
      Listing.new(id: row['id'],
                  name: row['name'],
                  description: row['description'],
                  price_per_night: row['price_per_night'].to_i,
                  user_id: row['user_id'])
    end
  end
end
