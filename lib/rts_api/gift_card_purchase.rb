module RtsApi
  # Response subclass for working with a gift card purchase response from RTS
  class GiftCardPurchase < Response
    def gift_number
      text_node('GiftNumber')
    end

    def transaction_id
      text_node('TransactionID')
    end
  end
end
