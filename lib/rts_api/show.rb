module RtsApi
  class Show
    attr_reader :datetime, :auditorium, :performance_id, :sale_link,
                :seats_remaining, :seats_sold, :sold_out, :low_seats,
                :ticket_type_codes

    include XmlReader

    def initialize(datetime:, auditorium:, performance_id:, sale_link:,
                   seats_remaining:, seats_sold:, sold_out:, low_seats:,
                   ticket_type_codes:)
      @datetime           = datetime
      @auditorium         = auditorium
      @performance_id     = performance_id
      @sale_link          = sale_link
      @seats_remaining    = seats_remaining
      @seats_sold         = seats_sold
      @sold_out           = sold_out
      @low_seats          = low_seats
      @ticket_type_codes  = ticket_type_codes
    end
  end
end
