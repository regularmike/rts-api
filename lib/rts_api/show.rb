module RtsApi

  class Show
    
    attr_reader :datetime, :auditorium, :performance_id, :sale_link, :seats_remaining, :seats_sold, :sold_out, :low_seats, :ticket_type_codes

    def initialize(attrs)
      @datetime           = attrs[:datetime]
      @auditorium         = attrs[:auditorium]
      @performance_id     = attrs[:performance_id]
      @sale_link          = attrs[:sale_link]
      @seats_remaining    = attrs[:seats_remaining]
      @seats_sold         = attrs[:seats_sold]
      @sold_out           = attrs[:sold_out]
      @low_seats          = attrs[:low_seats]
      @ticket_type_codes  = attrs[:ticket_type_codes]
    end

  end
 
end
