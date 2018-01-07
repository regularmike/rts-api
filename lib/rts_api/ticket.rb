module RtsApi
  class Ticket
    attr_reader :code, :name, :price, :tax

    include XmlReader

    def initialize(code:, name:, price:, tax:)
      @code = code
      @name = name
      @price = price
      @tax = tax
    end
  end
end
