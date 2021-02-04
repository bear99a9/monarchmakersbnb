class Booking

  attr_reader :id, :visitor_id, :listing_id, :status

  def initialize(id:, visitor_id:, listing_id:, status:)
    @id = id
    @visitor_id = visitor_id
    @listing_id = listing_id
    @status = status
  end

  def self.create(listing_id:, visitor_id:, status: 'pending')
    results = DatabaseConnection.safe_insert(table: 'booking', columns: ['listing_id', 'visitor_id', 'status'],
                                            values: [listing_id, visitor_id, status]).first
    Booking.new(id: results["id"],
                visitor_id: results["visitor_id"],
                listing_id: results["listing_id"],
                status: results["status"] )
  end

  def self.all
    results = DatabaseConnection.query("SELECT * FROM booking order by id desc")
    Booking.map_results(results)
  end

  def self.where(field:, id:)
    return nil unless id
    return nil unless field == "visitor" || field == "listing"
    results = DatabaseConnection.query("SELECT * FROM booking WHERE #{field}_id = '#{id}';")
    Booking.map_results(results)
  end

  def self.update(id:, status:)
    result = DatabaseConnection.query("update booking set status = '#{status}' where id = '#{id}'
      returning id, visitor_id, listing_id, status").first
      Booking.new(id: result["id"],
                  visitor_id: result["visitor_id"],
                  listing_id: result["listing_id"],
                  status: result["status"] )
  end

  private

  def self.map_results(results)
    results.map do |row|
      Booking.new(id: row['id'],
                  visitor_id: row['visitor_id'],
                  listing_id: row['listing_id'],
                  status: row['status'])
    end
  end
end
