module RtsApi
  # Response subclass for working with an RTS
  # gift card/loyalty card information response packet
  class GiftLoyaltyCardInformation < Response
    def debit_remain
      text_node('DebitRemain').to_f
    end
  end
end
