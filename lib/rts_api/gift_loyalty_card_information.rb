module RtsApi
  class GiftLoyaltyCardInformation < Response
    def debit_remain
      get_text_node('DebitRemain').to_f
    end
  end
end
