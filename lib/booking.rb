class Booking

  attr_reader :id, :visitor_id, :listing_id, :status

  def initialize(id:, visitor_id:, listing_id:, status:)
    @id = id
    @visitor_id = visitor_id
    @listing_id = listing_id
    @status = status
  end

  def self.create(listing_id:, visitor_id:, status: 'pending')
    results = DatabaseConnection.query("INSERT INTO booking (visitor_id, listing_id, status)
                                        VALUES ('#{visitor_id}', '#{listing_id}', '#{status}')
                                        returning id, visitor_id, listing_id, status").first

    Booking.new(id: results["id"],
                visitor_id: results["visitor_id"],
                listing_id: results["listing_id"],
                status: results["status"] )
  end

  def self.all
    results = DatabaseConnection.query("SELECT * FROM booking order by id desc")
    results.map do |row|
      Booking.new(id: row['id'],
                  visitor_id: row['visitor_id'],
                  listing_id: row['listing_id'],
                  status: row['status'])
                end
  end

  def self.find_all_by_user(visitor_id:)
    return nil unless visitor_id
    results = DatabaseConnection.query("SELECT * FROM booking WHERE visitor_id = '#{visitor_id}';")
    results.map do |row|
      Booking.new(id: row['id'],
                  visitor_id: row['visitor_id'],
                  listing_id: row['listing_id'],
                  status: row['status'])
                end
  end
end
