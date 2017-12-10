module RtsApi
    
  class Ticket

    attr_reader :code, :name, :price, :tax

    def initialize(attrs)
      @code = attrs[:code]
      @name = attrs[:name]
      @price = attrs[:price]
      @tax = attrs[:tax]
    end

  end
end
